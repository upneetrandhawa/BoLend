class ChangeColumnNameItems < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.rename :users_id, :user_id
    end
  end
end
