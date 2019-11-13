# frozen_string_literal: true

class PokemonSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :height, :weight
  has_many :evolutions, serializer: PokemonSerializer
  has_many :types
  has_many :stats
  has_many :moves

  def image
    return object.standard_image if object.image_url.url.nil?

    object.image_url.url
  end
end
