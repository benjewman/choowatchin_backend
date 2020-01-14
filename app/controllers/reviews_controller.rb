class ReviewsController < ApplicationController
    def show
        review = Review.find_by(id: params[:id])
        show = review.show
        user = review.user
        render json: {review: review, show: show, user: user}
    end

    def create
        # render json: {show: params[:show], id: params[:show]['id']}
        
        review = Review.new(review_params)
        show = Show.find_by(showId: params[:show]['id'])
        if show
            review.show = show
            review.save
            render json: {review: review, show: show}
        else
            new_show = Show.create(showId: params[:show]['id'], medium: params[:medium], poster: params[:show]['poster_path'])
            if (new_show.medium === 'movies') 
                new_show.title = params[:show]['title']
                new_show.save
            else 
                new_show.title = params[:show]['name']
                new_show.save
            end
            review.show = new_show
            review.save
            render json: {review: review, show: new_show}
        end
    end

    def update 
        review = Review.find_by(id: params[:id])
        if review
            review.update(review_params)
            review.save
            render json: review
        else 
            render json: {error: 'update failed'}
        end
    end

    private
    def review_params
        params.require(:review).permit(:stamp, :content, :user_id)
    end
end
