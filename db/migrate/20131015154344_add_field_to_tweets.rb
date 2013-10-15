class AddFieldToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :profile_image_url, :string
    add_column :tweets, :screen_name, :string
    add_column :tweets, :name, :string
  end
end
