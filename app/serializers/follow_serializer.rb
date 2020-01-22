class FollowSerializer < ActiveModel::Serializer
  attributes :id, :leader_id, :follower_id

  has_many :leaders, each_serializer: LeaderSerializer
end
