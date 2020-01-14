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

    def destroy
        follow = Follow.find_by(leader_id: params[:leader_id], follower_id: params[:follower_id])
        if follow 
            follow.destroy
            render json: { leader_id: params[:leader_id] }
        else
            render json: { error: 'unfollow failed' }
        end
    end

    private
    def follow_params
        params.require(:follow).permit(:follower_id, :leader_id)
    end
end