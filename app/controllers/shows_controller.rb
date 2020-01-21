class ShowsController < ApplicationController
    def show
        # might need to change showId back to id if something breaks
        show = Show.find_by(showId: params[:id])
        if show 
            render json: show
        else
            render json: { error: 'show not found' }
        end
    end
end
