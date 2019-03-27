class Family < ApplicationRecord
	validates :name, presence: true, length: {minimum: 1, maximum: 30}
	has_and_belongs_to_many :users, :through => :families_users
end
