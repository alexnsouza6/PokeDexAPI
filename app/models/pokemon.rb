class Pokemon < ApplicationRecord
  # Associations
  has_many :evolutions

  # Validations
  validates :name, presence: true
end
