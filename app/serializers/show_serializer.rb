class ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :medium, :showId, :poster
  has_many :reviews

  def reviews
    custom_reviews = []

    object.reviews.each do |review|
        custom_review = review.attributes
        custom_review[:user] = review.user
        custom_reviews.push(custom_review)
    end

    return custom_reviews
  end
end
