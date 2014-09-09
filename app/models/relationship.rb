class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  validates :follower, presence: true
  validates :following, presence: true
  validate :cannot_add_self

end

private 

	def cannot_add_self
		errors.add(:follower_id, "You cannot follow yourself!") if follower_id == following_id
	end
