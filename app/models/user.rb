class User < ApplicationRecord
    has_one_attached :avatar
    validates :email, uniqueness: true
    validates :username, uniqueness: { case_sensitive: false, message: 'username taken' }
    has_secure_password
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :leaders, through: :followed_users
    has_many :following_users, foreign_key: :leader_id, class_name: 'Follow'
    has_many :followers, through: :following_users
    has_many :reviews, dependent: :destroy
    has_many :shows, through: :reviews
    accepts_nested_attributes_for :reviews

end
