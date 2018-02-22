class User < ApplicationRecord
  has_secure_password
  has_many :calendar_events
  has_many :categories, through: :calendar_events
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
