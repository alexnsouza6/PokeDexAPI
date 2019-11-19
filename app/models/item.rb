class Item < ApplicationRecord
  
  # Validations
  validates :name, presence: true
  validates :effect, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
end
