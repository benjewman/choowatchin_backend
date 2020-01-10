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
        leaders = user.leaders
        
        leader_reviews = Review.all.where(user_id: leaders)
        ordered_leader_reviews = leader_reviews.order({ created_at: :desc})
        p '=============='

        if user 
            # Refactor below JSON
            render json: { user: user, leaders: user.leaders, leader_reviews: ordered_leader_reviews, user_reviews: user.reviews}
        end
    end

    def topfive
        users = User.all
        sorted_users = users.sort_by { |user| user.leaders.size }
        render json: { sorted_users: sorted_users }
    end

    
    private
    def user_params
        params.require(:user).permit(:username, :email, :full_name, :password)
    end
end
