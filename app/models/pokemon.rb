# Pokemon model handles Pokemon associations and validations as well
class Pokemon < ApplicationRecord
  # Associations
  has_many :evolutions, class_name: "Pokemon",
                          foreign_key: "evolution_id"
 
  belongs_to :pokemon, class_name: "Pokemon", foreign_key: "evolution_id", optional: true

  has_many :pokemon_types
  has_many :types, through: :pokemon_types

  # Validations
  validates :name, presence: true
  validates :image_url, presence: true

end
