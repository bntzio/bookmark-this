class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    @bookmarks = Bookmark.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
