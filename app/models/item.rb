class Item < ApplicationRecord
	belongs_to :shopping_list
	belongs_to :family
	belongs_to :items_enum
end
