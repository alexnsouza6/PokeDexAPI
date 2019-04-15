# frozen_string_literal: true

class PokemonSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :types, :evolutions
end
