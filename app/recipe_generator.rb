require 'json'
require '../config/environment.rb'

recipes = JSON.parse File.open('./recipes.json').read

recipes.each do |recipe|
    rec = Recipe.create name: recipe[1]["name"]
    
    recipe[1]["ingredients"].each do |ingredient|
        ir = ItemsRecipe.new
        ir.recipe_id = rec.id
        ir.items_enum_id = ingredient["id"]
        ir.quantity = ingredient["quantity"]
        ir.quantity_unit = ingredient["quantity_unit"]
        ir.save
    end
    
end
