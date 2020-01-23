class ReviewSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers
  attributes :id, :stamp, :content, :show_id, :show , :user 
  belongs_to :user, include_nested_attributes: :true

  def user
    #  user = object.user.attributes
    #  if object.avatar.attached?
    #   user['avatar'] = object.user.avatar.service_url
    #   # url_for(object.user.avatar)
    #  else 
    #   user['avatar'] = object.user.pic
    #  end
    #  return user
  end 

end
