class AddQueryToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :query, :string
  end
end
