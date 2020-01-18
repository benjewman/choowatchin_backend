class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :username, :full_name, :email, :pic, :avatar
  has_many :reviews
  has_many :leaders
  has_many :followers

  def avatar
    object.avatar.service_url if object.avatar.attached?
  end
end
