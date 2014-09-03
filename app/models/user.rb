class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true
  validates :name, presence: true

  has_many :tweets
  has_many :favorites

  def tweet!(tweet_params)
    self.tweets.create!(tweet_params)
  end

  def favorite!(tweet)
    self.favorites.create!(tweet: tweet)
  end

  def unfavorite!(tweet)
    self.favorites.find(tweet.id).destroy
  end
end
