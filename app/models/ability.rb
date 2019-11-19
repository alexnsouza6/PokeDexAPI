class Ability < ApplicationRecord

  # Validations
  validates :name, presence: true
  validates :description, presence: true
end
