class AddStandardImageToPokemon < ActiveRecord::Migration[5.2]
  def change
    add_column :pokemons, :standard_image, :string 
  end
end
