# This model handles N to N relationship between Pokemon and Type models
class PokemonType < ApplicationRecord

  # Associations
  belongs_to :pokemon
  belongs_to :type
end
