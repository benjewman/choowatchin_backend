class ReviewSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers
  attributes :id, :stamp, :content, :show_id, :user, :show
  belongs_to :user, include_nested_attributes: :true

  def user
     user = object.user.attributes
     user['avatar'] = url_for(object.user.avatar)
     return user
  end 

end
