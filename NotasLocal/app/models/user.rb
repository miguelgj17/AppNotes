class User < ApplicationRecord
	has_many :notes, dependent: :destroy
	validates_uniqueness_of :name
	has_many :friend_requests, dependent: :destroy
	has_many :pending_friends, through: :friend_requests, source: :friend
	has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships

    def remove_friend(friend)
    	current_user.friends.destroy(friend)
    end
end
