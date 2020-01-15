class UsersController < ApplicationController
    wrap_parameters :user, include: [:full_name, :password, :username, :email]
    def index
        users = User.all
        render json: users
    end
    
    def create
        user = User.new(user_params)
        user.pic = 'https://react.semantic-ui.com/images/avatar/large/matthew.png'
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
        backwards_sorted = leaders.sort_by { |leader| leader.followers.size}
        sorted_leaders = backwards_sorted.reverse
        
        leader_reviews = Review.all.where(user_id: leaders)
        ordered_leader_reviews = leader_reviews.order({ created_at: :desc })
        ordered_user_reviews = user.reviews.order({ created_at: :desc })
        p '=============='

        if user 
            # Refactor below JSON

            render json: { user: user, leaders: sorted_leaders, leader_reviews: ordered_leader_reviews, user_reviews: ordered_user_reviews }

            # below might work instead
            # serializers might be working now

            # render json: user
        end
    end

    def topfive
        users = User.all
        backwards_sorted = users.sort_by { |user| user.followers.size }
        sorted_users = backwards_sorted.reverse()
        top_five = sorted_users[0..4]
        follower_count_array = top_five.map { |user| user.followers.size }
        render json: { top_five: top_five, follower_count_array: follower_count_array }
    end

    def update
        user = User.find_by(id: params[:id])
        if user
            user.update(user_params)
            user.save
            render json: user
        else
            render json: { error: 'did not update' }
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :full_name, :password)
    end
end
