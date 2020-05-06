class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :username, :full_name, :email, :pic, :avatar, :followed_reviews
  has_many :reviews, include_nested_attributes: :true
  has_many :leaders
  has_many :followers

  def followed_reviews
    leaders = object.leaders.map { |leader| leader.id }
    leaders_plus = leaders.push(object.id)
    leader_reviews = Review.all.where(user_id: leaders_plus)
    followed_reviews = leader_reviews.order({ created_at: :desc})
    return followed_reviews
  end
  
  def avatar
    
    if object.avatar.attached?
      url_for(object.avatar) 
      # change back to the below when push to heroku

      # object.avatar.service_url

      # p URI.parse(URI.encode(object.avatar.service_url))
      
    else
      object.pic
    end

  end


end
