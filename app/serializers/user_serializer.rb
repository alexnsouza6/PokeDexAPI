class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :account_id, :pokemons

  def pokemons
    object.pokemons.map do |pokemon|
      PokemonSerializer.new(pokemon)
    end
  end
end
