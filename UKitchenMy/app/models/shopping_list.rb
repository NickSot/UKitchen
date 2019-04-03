class ShoppingList < ApplicationRecord
	validates :name, presence: true

	belongs_to :family
	has_many :items
end
