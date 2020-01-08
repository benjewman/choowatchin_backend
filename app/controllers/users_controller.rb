class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
            puts '------------------------------------------'
            puts user
        else
            puts '---------------------------------------'
            puts 'NOPE'
        end
    end 

    def show

    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :full_name, :password)
    end
end
