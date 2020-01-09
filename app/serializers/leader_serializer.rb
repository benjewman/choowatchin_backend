class LeaderSerializer < ActiveModel::Serializer
  attributes :id, :username, :full_name, :email
  has_many :reviews
end
