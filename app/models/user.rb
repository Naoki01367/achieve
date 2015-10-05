class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil) 
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user 
    user = User.create(name: auth.extra.raw_info.name, provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0,20]) 
    end 
    user

  end  
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil) 
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user 
    user = User.create(name: auth.info.nickname, provider: auth.provider, uid: auth.uid, email: User.create_unique_email, password: Devise.friendly_token[0,20]) 
    end 
    user

  end
  
  #Twitter認証時のemail用にuuidのランダムな文字列を生成する処理
  def self.create_unique_string 
    SecureRandom.uuid 
  end
  
  def self.create_unique_email 
    User.create_unique_string + "@example.com" 
  end
  
  has_many :blogs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
     #    :recoverable, :rememberable, :trackable, :validatable, :confirmable # confirmableを追加
end
