class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_bookmarks = @user.bookmarks
    @liked_bookmarks = @user.likes
  end

  def profile
    @user = current_user
    @user_bookmarks = @user.bookmarks
    @liked_bookmarks = @user.likes
  end
end
