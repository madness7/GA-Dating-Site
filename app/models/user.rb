class User < ActiveRecord::Base

  RANSACK_PREDICATES = {"starts with" => :start, "contains" => :cont, "matches" => :match, "equals" => :eq}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,  :omniauthable, omniauth_providers: [:facebook]
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :dob, :image_1, :image_2, :image_3, :gender, :looking_for, :profile_pic, :about_me, :post_code, :provider, :uid, :interest_ids
  # attr_accessible :title, :body

  has_many(:user_connections, :foreign_key => :user_1_id, :dependent => :destroy)
  has_many(:reverse_user_connections, :class_name => :UserConnection, :foreign_key => :user_2_id, :dependent => :destroy)
  has_many :users, :through => :user_connections, :source => :user_2
  has_and_belongs_to_many :interests


  has_many(:chats, :foreign_key => :user_1_id, :dependent => :destroy)
  has_many(:reverse_chats, :class_name => :Chat, :foreign_key => :user_2_id, :dependent => :destroy)
  has_many :users, :through => :chats, :source => :user_2
  has_many :posts, :through => :post_connections, :source => :post_b

  mount_uploader :image_1, Image1Uploader
  mount_uploader :image_2, Image2Uploader
  mount_uploader :image_3, Image3Uploader
  
     def self.interests(users, interest)
   users.reject{|user| !user.interests.pluck(:name).include?(interest)}    
    end

    def self.looking(sex, target_sex)
        self.where({gender: sex,looking_for: target_sex})
    end

    def self.search(search)
      if search
        find(:all, :conditions => ['first_name LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :image_1, presence: true
    validates :image_2, presence: true
    validates :image_3, presence: true
    validates :about_me, presence: true

  UNRANSACKABLE_ATTRIBUTES = ["reset_password_token", "reset_password_sent_at", "remember_created_at", "created_at", "dob", "image_1", "image_2", "image_3", "profile_pic", "uid", "provider", "updated_at", "unconfirmed_email", "confirmation_sent_at", "confirmed_at", "confirmation_token", "last_sign_in_ip", "current_sign_in_ip", "last_sign_in_at",  "current_sign_in_at", "sign_in_count", "encrypted_password", "user_id", "id", "about_me"  ]

  def self.ransackable_attributes auth_object = nil
      (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
  
  def self.from_omniauth(auth)
    
    twitter_email = if auth.provider =="twitter" then auth.info.nickname.downcase + "@twitter.com" end
    instagram_email = if auth.provider =="instagram" then auth.info.nickname.downcase + "@instagram.com" end
  
    if user = User.find_by_email(auth.info.email) || user = User.find_by_email(twitter_email) || user = User.find_by_email(instagram_email) 
      # user.provider = auth.provider
      user.uid = auth.uid
      user.image_1 = auth.info.image
      if auth.provider == "facebook"
        # user.facebook_token = auth.credentials.token
      else
        # user.instagram_token = auth.credentials.token
      end
      user
    else
      
      if auth.provider == "twitter"
          test = User.create({
              # :provider => auth.provider,
              :uid => auth.uid,
              :email => auth.info.nickname.downcase + "@twitter.com",
              # :image => auth.info.image,
              :password => Devise.friendly_token[0,20]
          })

      elsif auth.provider == "instagram"
          test = User.create({
              :provider => auth.provider,
              :uid => auth.uid,
              :email => auth.info.nickname.downcase + "@instagram.com",
              :image => auth.info.image,
              :password => Devise.friendly_token[0,20],
              :instagram_token => auth.credentials.token
          })
          
      else
        where(auth.slice(:provider, :uid)).first_or_create do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.first_name = auth.info.first_name
            user.last_name = auth.info.last_name
            user.email = auth.info.email
            user.gender = auth.info.gender
            user.image_1 = auth.info.image
            user.password = Devise.friendly_token[0,20]
            # user.facebook_token = auth.credentials.token
        end
      end 
    end
  end

  def self.other_users
    find_by_sql("select * from users where id != current_user_id")
  end

  def self.same_looking_for ()
    where("looking_for == current_user.gender")
  end
  def self.same_gender ()
    where("gender == current_user.looking_for")
  end




end

