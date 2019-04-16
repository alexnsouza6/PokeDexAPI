# frozen_string_literal: true

class PokemonSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :types
  has_many :evolutions, serializer: PokemonSerializer

  def image
    return object.standard_image if object.image_url.url.nil?

    object.image_url.url
  end
end
