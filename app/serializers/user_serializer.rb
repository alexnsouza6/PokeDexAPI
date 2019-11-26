class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :account_id, :pokemons

  def pokemons
    object.pokemons.map do |pokemon|
      {
        pokemon: pokemon,
        types: pokemon.types
      }
    end
  end
end
