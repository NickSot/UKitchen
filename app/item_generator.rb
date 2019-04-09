require '../config/environment.rb'

listOfItems = []
if ARGV != []
    ARGV.each do |arg|
        name = arg.split(',')[0]
        price = Float(arg.split(',')[1])
        puts price

        listOfItems << {'name' => name, 'price' => price}

        
    end
else
    file = File.open('./items.txt').read

    file.each_line do |line|
        name = line.split(',')[0]
        price = Float(line.split(',')[1])

        listOfItems << {'name' => name, 'price' => price}
    end
end

File.truncate('./items.txt', 0)

ItemsEnum.create listOfItems