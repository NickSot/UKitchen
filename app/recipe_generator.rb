require 'json'

recipes = JSON.parse File.open('./recipes.json').read

recipes.each do |recipe|
    puts recipe[1]
end
