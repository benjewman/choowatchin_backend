class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :full_name, :email
  has_many :reviews
  has_many :leaders
end
