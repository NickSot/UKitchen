class ItemsRecipe < ApplicationRecord
    belongs_to :items_enum
    belongs_to :recipe
end
