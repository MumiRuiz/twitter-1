require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: 'guille', email: 'guille@guille.com', password: '1234', password_confirmation: '1234', name: 'Guillermo')
  end

  def test_tweet
    @user.tweet!(text: "Hello, world!")
    tweet = @user.tweets.last

    assert_equal 1, @user.tweets.count
    assert_equal "Hello, world!", tweet.text
  end

  def test_fav_tweet
    tweet = @user.tweet!(text: "Hello, world!")
    # tweet = Tweet.new(...)
    # tweet.save
    @user.favorite!(tweet)

    assert_equal 1, @user.favorites.count
  end

  def test_unfav_tweet
    tweet = @user.tweet!(text: "Hello, world!")
    @user.favorite!(tweet)
    assert_equal 1, @user.favorites.count

    @user.unfavorite!(tweet)
    assert_equal 0, @user.favorites.count
  end

  def test_faved
    tweet = @user.tweet!(text: "Hello, world!")
    # assert_equal false, @user.faved?(tweet)
    assert !@user.faved?(tweet)

    @user.favorite!(tweet)
    # assert_equal true, @user.faved?(tweet)
    assert @user.faved?(tweet)
  end

  def test_follow
    user2 = User.create!(username: 'laura', email: 'laura@laura.com', password: '1234', password_confirmation: '1234', name: 'Laura')
    assert_equal 0, user2.followings.count
    assert_equal 0, @user.followers.count

    user2.follow(@user)

    assert_equal 1, user2.followings.count
    assert_equal 1, @user.followers.count
  end

  def test_unfollow
    user2 = User.create!(username: 'laura', email: 'laura@laura.com', password: '1234', password_confirmation: '1234', name: 'Laura')
    user2.follow(@user)

    assert_equal 1, user2.followings.count
    assert_equal 1, @user.followers.count

    user2.unfollow(@user)
    assert_equal 0, user2.followings.count
    assert_equal 0, @user.followers.count
    assert @user.persisted?
  end
end
