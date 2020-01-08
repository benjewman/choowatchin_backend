class UsersController < ApplicationController
    wrap_parameters :user, include: [:full_name, :password, :username, :email]
    def index
        users = User.all
        render json: users
    end
    
    def create
        user = User.new(user_params)
        if user.save
            puts '------------------------------------------'
            puts user
            render json: user
        else
            byebug
            puts '---------------------------------------'
            puts 'NOPE'
            render json: {error: 'whoopsie'}
        end
    end 

    def show

    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :full_name, :password)
    end
end
