class Pokemon < ApplicationRecord
  # Associations
  has_many :evolutions

  # Validations
  validates :name, presence: true
  validates :image_url, presence: true
end
