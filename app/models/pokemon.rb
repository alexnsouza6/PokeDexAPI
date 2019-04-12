class Pokemon < ApplicationRecord
  has_many :evolutions, class_name: "Pokemon",
                          foreign_key: "evolution_id"
 
  belongs_to :pokemon, class_name: "Pokemon", foreign_key: "evolution_id", optional: true

  has_many :pokemon_types
  has_many :types, through: :pokemon_types

  validates :name, presence: true

end
