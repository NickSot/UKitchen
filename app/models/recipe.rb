class Recipe < ApplicationRecord
    has_many :items_enums, through: :items_recipes
end