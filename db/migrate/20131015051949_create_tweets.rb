class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text, :null => false, :default => ""
      t.datetime :created_at

      t.timestamps
    end
  end
end
