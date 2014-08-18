class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dob, :date
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :image_1, :string
    add_column :users, :image_2, :string
    add_column :users, :image_3, :string
    add_column :users, :gender, :string
    add_column :users, :looking_for, :string
    add_column :users, :profile_pic, :string
    add_column :users, :about_me, :text
    add_column :users, :post_code, :string
  end
end
