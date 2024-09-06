# == Schema Information
#
# Table name: customers
#
#  id           :bigint           not null, primary key
#  email        :string           not null, indexed
#  name         :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_customers_on_email  (email) UNIQUE
#
class Customer < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :orders, dependent: :destroy
end
