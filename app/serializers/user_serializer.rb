class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :account_id
  has_many :pokemons
end
