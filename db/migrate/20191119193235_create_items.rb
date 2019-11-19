class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :effect
      t.string :short_description
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
