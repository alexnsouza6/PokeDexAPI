class AddReferencesToPokemon < ActiveRecord::Migration[5.2]
  def change
    add_reference :pokemons, :evolution, index: true
  end
end
