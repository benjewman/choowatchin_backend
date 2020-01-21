class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :stamp, :content, :show_id, :user_id
  belongs_to :show
  belongs_to :user
end
