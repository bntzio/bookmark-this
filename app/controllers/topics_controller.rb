class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    @bookmarks = Bookmark.all
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmark = Bookmark.find(params[:id])
  end

  def new
  end

  def edit
  end
end
