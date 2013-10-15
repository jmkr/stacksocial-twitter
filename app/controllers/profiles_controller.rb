class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @tweets = Tweet.get_latest_for_user(params[:user_name])
  end
end