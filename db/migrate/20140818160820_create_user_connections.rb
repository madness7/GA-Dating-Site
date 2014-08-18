class CreateUserConnections < ActiveRecord::Migration
  def change
    create_table :user_connections do |t|
      t.integer :user_1_id
      t.integer :user_2_id
      t.boolean :interacted
      t.boolean :negative_connection

      t.timestamps
    end
  end
end
