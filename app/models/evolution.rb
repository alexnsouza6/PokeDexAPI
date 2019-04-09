class Evolution < ApplicationRecord
  # Associations
  belongs_to :pokemon

  # Validations
  validates :name, presence: true
end
