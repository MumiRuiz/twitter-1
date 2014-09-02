class Tweet < ActiveRecord::Base
  validates :text, presence: true#, length: { maximum: 140 }
  validates_length_of :text, maximum: 140, message: "Tweet can't be longer than 140 chars"

  belongs_to :user
end
