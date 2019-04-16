# frozen_string_literal: true

# Pokemon model handles Pokemon associations and validations as well
class Pokemon < ApplicationRecord
  # Associations
  has_many :evolutions, class_name: 'Pokemon',
                        foreign_key: 'evolution_id'

  belongs_to :pokemon, class_name: 'Pokemon', foreign_key: 'evolution_id', optional: true

  has_many :pokemon_types, dependent: :destroy
  has_many :types, through: :pokemon_types

  # Validations
  validates :name, presence: true

  mount_uploader :image_url, ImageUrlUploader
end
