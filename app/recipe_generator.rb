require 'json'
require '../config/environment.rb'

recipes = JSON.parse File.open('./recipes.json').read

recipes.each do |recipe|
    rec = Recipe.create name: recipe[1]["name"], text: recipe[1]["text"]

    
    recipe[1]["ingredients"].each do |ingredient|
        ir = ItemsRecipe.new
        ir.recipe_id = rec.id
        ir.items_enum_id = ingredient["id"]
        ir.quantity = ingredient["quantity"]
        # ir.recipe_text = recipe[1]["text"]
        ir.save
    end
    
end
