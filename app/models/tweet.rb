class Tweet < ActiveRecord::Base
  attr_accessible :text, :created_at, :query, :screen_name, :name, :profile_image_url

  # Connect to Twitter API and fetch the latest 20 tweets for the given user.
  def self.get_latest_for_user(user_name)
    tweets = client.user_timeline(user_name)
    tweets.each do |t|
      # Create and save the tweet if it doesn't already exist.
      unless Tweet.where(created_at: t.created_at).exists?
        tweet = Tweet.create(:text => t.text, :created_at => t.created_at)
        tweet.save
       end
    end
  end

  # Connect to the Twitter API and fetch the latest 20 tweets for the given search term, excluding retweets.
  def self.get_latest_for_query(query)
    unless query.nil? || query.empty?
      search_results = client.search(query + " -rt", :count => 20, :result_type => "recent")
      search_results.statuses.each do |t|
        # Create and save the tweet if it doesn't already exist for the given query.
        unless Tweet.where(created_at: t.created_at, query: query).exists?
          tweet = Tweet.create(:text => t.text, :created_at => t.created_at, :query => query)
          tweet.save
        end
      end
    end
  end

  private

  def self.client
    client = Twitter::Client.new(
      :consumer_key        => ENV["TWITTER_CONSUMER_KEY"],
      :consumer_secret     => ENV["TWITTER_CONSUMER_SECRET"],
      :oauth_token        => ENV["TWITTER_ACCESS_TOKEN"],
      :oauth_token_secret => ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    )
  end 
end
