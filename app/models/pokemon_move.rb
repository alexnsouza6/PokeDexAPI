# This model handles N to N relationship between Pokemon and Move models
class PokemonMove < ApplicationRecord

    # Associations
    belongs_to :pokemon
    belongs_to :move
  end
  