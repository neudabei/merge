class User < ActiveRecord::Base

  has_many :spreadsheets
  accepts_nested_attributes_for :spreadsheets

  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

end