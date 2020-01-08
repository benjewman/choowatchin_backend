class ShowsController < ApplicationController
    def show
        show = Show.find_by(id: params[:id])
        if show 
            render json: show
        else
            render json: { error: 'show not found' }
        end
    end
end
