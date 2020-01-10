class FriendsController < ApplicationController
    def index
        user = User.find_by(id: params[:id])
        friends = user.leaders
        render json: friends
    end
    
end