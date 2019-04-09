class CreateEvolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :evolutions do |t|
      t.string :name
      t.string :image_url
      t.references :pokemon, foreign_key: true

      t.timestamps
    end
  end
end
