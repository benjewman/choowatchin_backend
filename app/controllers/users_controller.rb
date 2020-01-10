class UsersController < ApplicationController
    wrap_parameters :user, include: [:full_name, :password, :username, :email]
    def index
        users = User.all
        render json: users
    end
    
    def create
        user = User.new(user_params)
        if user.save
            token = JWT.encode({user_id: user.id}, 'chookey', 'HS256')
            render json: { user: user, token: token }
        else
            render json: {error: 'unable to create user'}
        end
    end 


    def show
        user = User.find_by(id: params[:id])
        # reviews = user.reviews
        leaders = user.leaders
        followed_reviews = leaders.map{ |leader| leader.reviews }
        # ordered_followed_reviews = followed_reviews.sort { |a, b| b.created_at <=> a.created_at }
        # ordered_reviews = user.reviews.sort('created_at desc')
        if user 
            # Refactor below JSON
            render json: { user: user, leaders: user.leaders, followed_reviews: followed_reviews, reviews: user.reviews}
        end
    end

    
    private
    def user_params
        params.require(:user).permit(:username, :email, :full_name, :password)
    end
end
