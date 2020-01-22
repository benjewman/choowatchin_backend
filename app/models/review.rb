class Review < ApplicationRecord
    belongs_to :user
    belongs_to :show
    validates :user_id, uniqueness: { scope: [:show_id] }
end
