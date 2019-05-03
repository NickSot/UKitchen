require '../config/environment.rb'

listOfItems = []
if ARGV != []
    ARGV.each do |arg|
        name = arg.replace(' ', '')

        listOfItems << {'name' => name}

        
    end
else
    file = File.open('./items.txt').read

    file.each_line do |line|
        name = line

        listOfItems << {'name' => name}
    end
end

# File.truncate('./items.txt', 0)

ItemsEnum.create listOfItems