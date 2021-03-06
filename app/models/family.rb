class Family < ApplicationRecord
    validates :name, presence: true

    belongs_to :administrator
    has_many :shopping_lists
    has_many :items
    has_many :transactions
    has_and_belongs_to_many :users, :through => :families_users
end
