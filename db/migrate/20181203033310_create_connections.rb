class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.references :user, foreign_key: true
      t.integer :follows
      t.timestamps
    end
  end
end
