require '../config/environment.rb'

currentItems = ItemsEnum.all
newItems = []
if ARGV != []
    ARGV.each do |arg|
        name = arg.replace(' ', '').delete!("\n")

        newItems << {'name' => name}        
    end
else
    file = File.open('./items.txt').read

    file.each_line do |line|
        line.delete!("\n")
        line = line.split(' ')
        name = line[0]
        category = line[1]
        quantity_unit = line[2]
        found = false;
        
        currentItems.each{|item| item['name'].include?(name) ? found = true : nil}

        if !found
            newItems << {'name' => name.gsub('_', ' '), 'category_name' => category, 'quantity_unit' => quantity_unit}
        end
    end
    puts(newItems.empty? ? "Nothing to be done...\n" : newItems )
end

# File.truncate('./items.txt', 0)

ItemsEnum.create newItems