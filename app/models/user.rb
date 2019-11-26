class User < ApplicationRecord
  # Associations
  has_many :user_pokemons, dependent: :destroy
  has_many :pokemons, through: :user_pokemons
  # Validations
  validates :account_id, presence: true
end
