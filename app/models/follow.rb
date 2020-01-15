class Follow < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :leader, class_name: 'User'
    
    # validate :leader_and_follower_must_be_different
    
    # create validation leader_id and 
    # follower_id must be different
    # leader_id and follower_id must also be unique together
    def leader_and_follower_must_be_different
        if leader_id === follower_id 
            errors.add(:leader_id, 'must be different than follower_id')
        end
    end
    
end
