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

    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :full_name, :password)
    end
end
