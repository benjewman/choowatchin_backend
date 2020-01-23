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
            render json: {error: user.errors.messages}
        end
    end 


    def show
        user = User.find_by(id: params[:id])
        if user 
            leaders = user.leaders
            backwards_sorted = leaders.sort_by { |leader| leader.followers.size}
            sorted_leaders = backwards_sorted.reverse
            
            leader_reviews = Review.all.where(user_id: leaders)
            ordered_leader_reviews = leader_reviews.order({ created_at: :desc })
            ordered_user_reviews = user.reviews.order({ created_at: :desc })

        
            # render json: { user: user, leaders: sorted_leaders, leader_reviews: ordered_leader_reviews, user_reviews: ordered_user_reviews }
            render json: user
        else
            render json: {error: 'user not found'}
        end
    end

    def topfive
        users = User.all
        backwards_sorted = users.sort_by { |user| user.followers.size }
        sorted_users = backwards_sorted.reverse()
        top_five = sorted_users[0..4]
        render json: top_five
    end

    def update
        params.inspect
        user = User.find_by(id: params[:id])
        if user && params[:user][:avatar]
            user.avatar.attach(params[:user][:avatar])
            user.save
            render json: user
        elsif user
            user.update(user_params)
            user.save
            render json: user
        else
            render json: { error: 'did not update' }
        end
        # if user
        #     user.update(user_params)
        #     user.save
        #     render json: user
        # else
        #     render json: { error: 'did not update' }
        # end
    end

    # def avatar
    #     user = User.find_by(id: params[:id])

    #     if user&.avatar&.attached?
    #         redirect_to rails_blob_url(user.avatar)
    #     else
    #         head :not_found
    #     end
    # end
    
    def destroy
        user = User.find_by(id: params[:id])
        if user
            user.destroy
            render json: { message: 'user deleted' }
        else
            render json: { message: 'delete failed' }
        end
    end

    def log_in
        user = User.find_by(username: params['username'])
        if user && user.authenticate(params['password'])
            token = JWT.encode({user_id: user.id}, 'chookey', 'HS256')
            render json: { user: user, token: token }
        else
            render json: { error: 'invalid credentials' }, status: 401
        end
    end

    def auth
        token = request.headers['Authorization'].split(' ')[1]
        user_id = JWT.decode(token, 'chookey', true, { algorithm: 'HS256' })[0]['user_id']
        user = User.find_by(id: user_id)
        if user 
            # user['avatar'] = url_for(user.avatar)
            leaders = user.leaders.map { |leader| leader.id }
            leaders_plus = leaders.push(user.id)
            leader_reviews = Review.all.where(user_id: leaders_plus)
            ordered_leader_reviews = leader_reviews.order({ created_at: :desc})
            render json: { user: user, followed_reviews: ordered_leader_reviews, leaders: user.leaders }
        else
            render json: { error: 'not signed in' }, status: 401
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :full_name, :password, :avatar)
    end
end
