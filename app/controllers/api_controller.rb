class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def news
    #render json: Tweet.last(50)
    tweets=Tweet.last(50)
    hash= tweets.map do |t|
      {
        :id  => t.id,
        :content => t.content,
        :user_id  => t.user_id,
        :like_count => t.likes.count,
        :retweets_count => t.count_rt,
        :retweeted_from => (t.rt_ref.nil? ? "" : t.rt_ref)
      }
    end

    render json: hash
  end

  def tweets_between_dates
    date1 = Date.parse(params[:date1])
    date2 = Date.parse(params[:date2])
    tweets=Tweet.where(created_at: date1..date2)
    hashes = tweets.map do |t|
      {
        :id  => t.id,
        :content => t.content,
        :user_id  => t.user_id,
        :like_count => t.likes.count,
        :retweets_count => t.count_rt,
        :retweeted_from => (t.rt_ref.nil? ? "" : t.rt_ref)
      }
    end
      render json: hashes
  end

  def create_tweet
    user=User.authenticate(params[:email], params[:password])
    unless user.nil?
    @tweet = Tweet.new(tweet_params)
    @tweet.user = User.first
    if @tweet.save
      render json: @tweet
    else
      render json: {errors: "error"}
    end
  end

  private
  def tweet_params
    parans.require(:tweet).permit(:content, :user_id)
end
