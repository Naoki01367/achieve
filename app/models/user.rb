class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :blogs
  has_many :comments
  
  #第一段階「中間テーブルと関係を定義する」
  has_many :relationships, foreign_key:"follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key:"followed_id", class_name:"Relationship", dependent: :destroy
  
  #第三段階「相対的な参照関係を定義する」
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  
  #指定のユーザーをフォローする
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  #指定のユーザーのフォローを解除する
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #フォローしているかどうかを確認する
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  #「自分が」フォローし合っているユーザー一覧を取得する
  def friend
    User.from_users_followed_by(self)
  end
  
  #フォローし合っているユーザー一覧を取得する
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT X.id FROM (SELECT users.*FROM users INNER JOIN relationships ON users.id = relationships.followed_id WHERE relationships.follower_id = :user_id)X INNER JOIN (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.follower_id WHERE relationships.followed_id = :user_id) Y ON X.id = Y.id"
    where("id IN (#{followed_user_ids})", user_id: user.id)
  end
    
  
  
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
