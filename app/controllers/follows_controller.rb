class FollowsController < ApplicationController
    def create
        follow = Follow.create(follow_params)
        leader = User.find(params[:leader_id])
        if follow
            render json: leader
        else 
            render json: { error: 'follow failed' }
        end
    end

    private
    def follow_params
        params.require(:follow).permit(:follower_id, :leader_id)
    end
end