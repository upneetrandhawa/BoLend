class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.string:body 
      t.integer:sender_id
      t.integer:recipient_id
      t.timestamps
    end
  end
end
