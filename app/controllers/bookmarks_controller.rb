class BookmarksController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark was saved successfully."
      redirect_to @topic
    else 
      flash[:error] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def edit
   @topic = Topic.find(params[:topic_id])
   @bookmark = Bookmark.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])

    name = @bookmark.url

    if @bookmark.update_attributes(bookmark_params)
      new_name = @bookmark.url 
      flash[:notice] = "\"#{name}\" is now \"#{new_name}\"."
      redirect_to @topic
    else
      flash[:error] = "Error updating bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])

    name = @bookmark.url

    if @bookmark.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the bookmark. Please try again."
      render :show
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

end
