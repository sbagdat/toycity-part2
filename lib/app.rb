require 'json'

def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end

def sales_heading
	" __       _               __                       _\n" <<
	"/ _\\ __ _| | ___  ___    /__\\ ___ _ __   ___  _ __| |_ \n" <<
	"\\ \\ / _` | |/ _ \\/ __|  / \\/// _ \\ '_ \\ / _ \\| '__| __|\n" <<
	"_\\ \\ (_| | |  __/\\__ \\ / _  \\  __/ |_) | (_) | |  | |_ \n" <<
	"\\__/\\__,_|_|\\___||___/ \\/ \\_/\\___| .__/ \\___/|_|   \\__|\n" <<
	"                                 |_|\n\n"
end

def products_heading
  "                     _            _       \n" <<
  "                    | |          | |      \n" <<
  " _ __  _ __ ___   __| |_   _  ___| |_ ___ \n" <<
  "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|\n" <<
  "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\\n" <<
  "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/\n" <<
  "| |                                       \n" <<
  "|_|                                       \n\n"
end

def brands_heading
	" _                         _     \n" <<
	"| |                       | |    \n" <<
	"| |__  _ __ __ _ _ __   __| |___ \n" <<
	"| '_ \\| '__/ _` | '_ \\ / _` / __|\n" <<
	"| |_) | | | (_| | | | | (_| \\__ \\\n" <<
	"|_.__/|_|  \\__,_|_| |_|\\__,_|___/\n\n"
end

def print_heading(type='sales')
  print_to_file  case type
					  	   when 'sales'    then sales_heading
					       when 'products' then products_heading
					       when 'brands'   then brands_heading
					       else 'There is no proper heading for this!'
					       end
end

def print_to_file(text)
	$report_file.puts text
end

def products_data
  all_products = []

	$products_hash["items"].each do |toy|
	  count_of_purchases = toy['purchases'].size
	  total_sales = toy['purchases'].reduce(0) { |total, t| total += t['price'] }
	  average_price = total_sales / count_of_purchases
    average_discount = (count_of_purchases * toy['full-price'].to_f - total_sales) / count_of_purchases
    average_discount_percentage = (average_discount * 100 / toy['full-price'].to_f).round(2)

	  product_item = {}
	  product_item['Title'] = toy['title']
	  product_item['Retail Price'] = "$#{toy['full-price']}"
	  product_item['Total Purchases'] = count_of_purchases
	  product_item['Total Sales'] = "$#{total_sales}"
	  product_item['Average Price'] = "$#{average_price}"
    product_item['Average Discount'] = "$#{average_discount}"
    product_item['Average Discount Percentage'] = "#{average_discount_percentage}%"

    all_products << product_item
	end

	all_products
end

def brands_data
  all_brands = []
	brands = $products_hash["items"].map {|item| item['brand']}.uniq

	brands.each do |brand|
	  items = $products_hash["items"].select {|item| item['brand'] == brand}
	  stock = items.reduce(0) {|total, item| total += item['stock']}
	  average_price = ((items.reduce(0) {|total, item| total += item['full-price'].to_f}) / items.size).round(2)
	  purchases = items.map {|item| item['purchases']}.flatten
    total_sales = purchases.reduce(0.0) {|total, item| total += item['price']}

		brand_item = {}
	  brand_item['Title'] = brand.upcase
	  brand_item['Number of Products'] = stock
	  brand_item['Average Product Price'] = "$#{average_price}"
	  brand_item['Total Sales'] = "$#{total_sales.round(2)}"

	  all_brands << brand_item
	end

	all_brands
end

def print_hash(hash)
  lines = []
  hash.each do |item|
		lines << item.shift.last # Print title
		lines << "********************"
		item.each do |key, value|
		  lines << "#{key}: #{value}"
		end
		lines << "********************\n"
	end

	print_to_file lines.join("\n")
end

def print_data(options = {})
	data = []

	if options[:type] == 'products'
		print_heading('products')
		data = products_data
	elsif options[:type] == 'brands'
		print_heading('brands')
		data = brands_data
	end

	print_hash(data)
end

def print_today
  print_to_file "Today's Date: #{Time.now.strftime("%m/%d/%Y")}\n"
end

def create_report
	print_heading
	print_today
	print_data({type: 'products'})
	print_data({type: 'brands'})
	print "Sales report printed into report.txt."
end

def start
  setup_files
  create_report
end

start
