class ReviewsController < ApplicationController
    def show
        review = Review.find_by(id: params[:id])
        show = review.show
        user = review.user
        render json: {review: review, show: show, user: user}
        # if review 
        #     fetch("http://www.omdbapi.com/?apikey=49f89f6c&i=#{review.show.imdbID}")
        #     .then(resp => resp.json())
        #     # BREAKING ON NEXT LINE
        #     .then(show => return render json: {review: review, show: show, user: review.user})
        # else
        #     render json: { error: 'review not found' }
        # end
    end
end
