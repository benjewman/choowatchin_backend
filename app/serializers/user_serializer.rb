class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  # temporarily deleted avatar attribute because it 
  # causes problems in Friends component
  attributes :id, :username, :full_name, :email, :pic
  has_many :reviews
  has_many :leaders
  has_many :followers

  def avatar
    object.avatar.service_url if object.avatar.attached?
    # return rails_blob_path(object.avatar, only_path: true)
  end
  # major issue with Invalid URI Error for avatar
end
