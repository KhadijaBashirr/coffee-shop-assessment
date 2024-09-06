class Customer < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :orders
end
