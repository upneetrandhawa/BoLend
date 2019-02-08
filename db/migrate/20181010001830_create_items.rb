class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.text :description
      t.integer :times_used
      t.boolean :available
      t.boolean :taken
      t.integer :times_used
      t.string :photo_link

      t.references :users, foreign_key: true
      t.timestamps
    end
  end
end
