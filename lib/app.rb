require 'json'

# Get path to products.json, read the file into a string,
# and transform the string into a usable hash
def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end

# methods go here
def start
  setup_files # load, read, parse, and create the files
  #create_report # create the report!
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
  puts case type
  	   when 'sales'    then sales_heading
       when 'products' then products_heading
       when 'brands'   then brands_heading
       else 'There is no proper heading for this!'
       end
end


start # call start method to trigger report generation

# Print "Sales Report" in ascii art
print_heading

# Print today's date

# Print "Products" in ascii art
print_heading('products')
# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price

# Print "Brands" in ascii art
print_heading('brands')
# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
