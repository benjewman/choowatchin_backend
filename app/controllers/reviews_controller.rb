class ReviewsController < ApplicationController
    def show
        review = Review.find_by(id: params[:id])
        show = review.show
        user = review.user
        render json: {review: review, show: show, user: user}
    end

    def create
        review = Review.new(review_params)
        show = Show.find_by(imdbID: params[:show]['id'])
        if show
            review.show = show
        else
            new_show = Show.create
        end
    end

    private
    def review_params
        params.require(:review).pertit(:stamp, :content, :medium, :user_id)
    end
end
