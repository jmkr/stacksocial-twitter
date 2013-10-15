class Tweet < ActiveRecord::Base
  attr_accessible :text, :created_at

  # Connect to Twitter API and fetch the latest tweets 20 tweets.
  def self.get_latest
    tweets = Twitter.user_timeline("meekr5")
    tweets.each do |t|
      created = DateTime.parse(t.created_at)
      
      # Create and save the tweet if it doesn't already exist.
      unless Tweet.where(created_at: created).exists?
        tweet = Tweet.create(:text => t.text, :created_at => created )
        tweet.save
       end
    end
  end
end
