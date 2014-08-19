class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :user_1_id
      t.integer :user_2_id
      t.text :message

      t.timestamps
    end
  end
end
