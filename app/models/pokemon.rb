# frozen_string_literal: true

# Pokemon model handles Pokemon associations and validations as well
class Pokemon < ApplicationRecord

  # Associations
  has_many :evolutions, class_name: 'Pokemon',
                        foreign_key: 'evolution_id'

  belongs_to :pokemon, class_name: 'Pokemon',
                       foreign_key: 'evolution_id',
                       optional: true

  has_many :stats
  has_many :pokemon_types, dependent: :destroy
  has_many :types, through: :pokemon_types

  has_many :pokemon_moves, dependent: :destroy
  has_many :moves, through: :pokemon_moves

  # Validations
  validates :name, presence: true

  mount_uploader :image_url, ImageUrlUploader
end
