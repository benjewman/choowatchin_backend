class ReviewSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers
  attributes :id, :stamp, :content, :show_id, :user, :show
  belongs_to :user, include_nested_attributes: :true

  def user
     user = object.user.attributes
     if object.avatar.attached?
      user['avatar'] = url_for(object.user.avatar)
     else 
      user['avatar'] = object.user.pic
     return user
  end 

end
