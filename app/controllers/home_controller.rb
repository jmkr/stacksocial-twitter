class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @query = params[:tweet_query]
    unless @query.nil? || @query.empty?
      @tweets = Tweet.get_latest_for_query(@query) || []
    else
      @tweets = Tweet.get_latest_for_query("stacksocial") || []
    end
  end
end