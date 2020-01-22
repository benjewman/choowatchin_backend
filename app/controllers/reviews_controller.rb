class ReviewsController < ApplicationController
    def index
        user_id = request.headers['UserId'].split(' ')[1]
        user = User.find_by(id: user_id)
        leaders = user.leaders.map { |leader| leader.id }
        leaders.push(user.id)
        reverse_reviews = Review.all.where(user_id: leaders)
        reviews = reverse_reviews.reverse()
        render json: reviews
    end
    
    def show
        review = Review.find_by(id: params[:id])
        show = review.show
        user = review.user
        render json: review
    end

    def create
        # render json: {show: params[:show], id: params[:show]['id']}
        
        review = Review.new(review_params)
        show = Show.find_by(showId: params[:show]['id'])
        if show
            review.show = show
            if review.save
                render json: {review: review, show: show}
            else
                render json: {error: 'can not review the same show twice'}
            end
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
            render json: {review: review}
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

    def destroy
        review = Review.find_by(id: params[:id])
        if review 
            review.destroy
            render json: { message: 'review deleted'}
        else
            render json: { error: 'delete failed' }
        end
    end
    
    private
    def review_params
        params.require(:review).permit(:stamp, :content, :user_id, :medium)
    end
end
