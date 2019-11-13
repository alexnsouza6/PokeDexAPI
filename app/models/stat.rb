class Stat < ApplicationRecord

  # Associations
  belongs_to :pokemon

  # Validations
  validates :value, presence: true
  validates :name, presence: true

end
