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
        user = User.find_by(id: user_id)
        if user 
            # user['avatar'] = url_for(user.avatar)
            leaders = user.leaders.map { |leader| leader.id }
            leaders_plus = leaders.push(user.id)
            leader_reviews = Review.all.where(user_id: leaders_plus)
            ordered_leader_reviews = leader_reviews.order({ created_at: :desc})
            render json: { user: user, followed_reviews: ordered_leader_reviews, leaders: user.leaders }
        else
            render json: { error: 'not signed in' }, status: 401
        end
    end
end

# serializer doesn't work properly in this because
# it's using user serializer and not in the user controller