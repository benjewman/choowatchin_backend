class AuthController < ApplicationController
    def create
        user = User.find_by(username: params['username'])
        if user && user.authenticate(params['password'])
            token = JWT.encode({user_id: user.id}, 'chookey', 'HS256')
            render json: { id: user.id, username: user.username, token: token }
        else
            render json: { error: 'invalid credentials' }, status: 401
        end
    end
end