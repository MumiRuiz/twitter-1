class TweetsController < ApplicationController
  before_action :redirect_unless_authenticated
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :fav, :unfav]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # POST /tweets
  # POST /tweets.json
  def create
    begin
      @tweet = current_user.tweet!(tweet_params)
      redirect_to tweets_path, notice: 'Tweet was successfully created.'
    rescue
      flash[:alert] = "Tweet couldn't be created."
      @tweets = Tweet.all
      render :index
    end
  end

  def fav
    current_user.favorite!(@tweet)
    redirect_to :back
  end

  def unfav
    current_user.unfavorite!(@tweet)
    redirect_to :back
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    redirect_to tweets_url, notice: 'Tweet was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:text, :attachment, :location)
    end
end
