class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :dob, :image_1, :image_2, :image_3, :gender, :looking_for, :profile_pic, :about_me, :post_code
  # attr_accessible :title, :body

  mount_uploader :image_1, Image1Uploader
  mount_uploader :image_2, Image2Uploader
  mount_uploader :image_3, Image3Uploader
end
