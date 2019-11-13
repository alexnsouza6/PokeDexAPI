class AddHeightWeightToPokemon < ActiveRecord::Migration[5.2]
  def change
    add_column :pokemons, :height, :integer
    add_column :pokemons, :weight, :integer
  end
end
