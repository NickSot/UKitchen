class Recipe < ApplicationRecord
    has_many :items_recipes
    
    has_many :ingredients, :through => :items_recipes, :source => :items_enum
end