class UserConnection < ActiveRecord::Base
  attr_accessible :interacted, :negative_connection, :user_1_id, :user_2_id

  belongs_to :user_1, :class_name => :User
  belongs_to :user_2, :class_name => :User
end



