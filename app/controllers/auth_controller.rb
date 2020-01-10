class AuthController < ApplicationController
    def create
        user = User.find_by(username: params['username'])
        if user && user.authenticate(params['password'])
            token = JWT.encode({user_id: user.id}, 'chookey', 'HS256')
            render json: { user: user, token: token }
        else
            render json: { error: 'invalid credentials' }, status: 401
        end
    end

    def show
        token = request.headers['Authorization'].split(' ')[1]
        user_id = JWT.decode(token, 'chookey', true, { algorithm: 'HS256' })[0]['user_id']
        user = User.find(user_id)
        if user 
            leaders = user.leaders
            flattened_reviews = []
            followed_reviews = leaders.map{ |leader| leader.reviews }
            followed_reviews.each { |array| flattened_reviews.concat(array) }
            render json: { user: user, followed_reviews: flattened_reviews }
        else
            render json: { error: 'not signed in' }, status: 401
        end
    end
end