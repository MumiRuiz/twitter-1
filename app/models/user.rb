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
    # self.favorites.create!(tweet_id: tweet.id)
    self.favorites.create!(tweet: tweet)
  end

  def unfavorite!(tweet)
    # self.favorites.find_by(tweet_id: tweet.id).destroy
    self.favorites.find_by(tweet: tweet).destroy
  end

  def faved?(tweet)
    # self.favorites.exists?(tweet_id: tweet.id)
    self.favorites.exists?(tweet: tweet)
  end
end
