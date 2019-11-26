class UserPokemon < ApplicationRecord

  # Associations
  belongs_to :pokemon
  belongs_to :user
end
