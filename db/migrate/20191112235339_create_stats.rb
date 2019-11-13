class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.references :pokemon, foreign_key: true
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
