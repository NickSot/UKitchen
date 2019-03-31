class User < ApplicationRecord
  has_secure_password

  validates :password, presence: true
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  has_and_belongs_to_many :families, :through => :families_users
end
