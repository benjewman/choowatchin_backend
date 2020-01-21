class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  # temporarily deleted avatar attribute because it 
  # causes problems in Friends component
  attributes :id, :username, :full_name, :email, :pic, :avatar, :foo
  has_many :reviews
  has_many :leaders
  has_many :followers
  # has_one_attached :avatar

  def foo
    p'-----------------------------------------'
    'foo'
  end

  def avatar
    # object.avatar.service_url if object.avatar.attached?
    url_for(object.avatar) if object.avatar.attached?
    # 'asdfasdfasdf'
    # return rails_blob_path(object.avatar, only_path: true)
  end
  # major issue with Invalid URI Error for avatar
end
