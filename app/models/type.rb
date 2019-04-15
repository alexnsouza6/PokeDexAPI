class Type < ApplicationRecord
  # Associations
  has_many :pokemon_types
  has_many :pokemons, through: :pokemon_types

  # Validations
  validates :description, presence: true
end
