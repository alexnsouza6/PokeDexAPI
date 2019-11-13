# frozen_string_literal: true

# Move class is responsible for Pokemon's moves.
class Move < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Associations
  has_many :pokemons, through: :pokemon_moves
  has_many :pokemon_moves, dependent: :destroy
end
