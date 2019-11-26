class CreateUserPokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :user_pokemons do |t|
      t.references :pokemon, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
