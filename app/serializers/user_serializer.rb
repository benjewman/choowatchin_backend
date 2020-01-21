class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  # temporarily deleted avatar attribute because it 
  # causes problems in Friends component
  attributes :id, :username, :full_name, :email, :pic, :avatar
  has_many :reviews, include_nested_attributes: :true
  has_many :leaders
  has_many :followers

  def avatar
    # object.avatar.service_url if object.avatar.attached?
    url_for(object.avatar) if object.avatar.attached?
  end
end
