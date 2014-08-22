class Chat < ActiveRecord::Base
  attr_accessible :message, :user_1_id, :user_2_id
#similar to the user connections model but had only one extra field, the message.
  belongs_to :user_1, :class_name => :User
  belongs_to :user_2, :class_name => :User
end
