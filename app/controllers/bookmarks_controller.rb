class BookmarksController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new

    authorize @bookmark
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(bookmark_params)

    @bookmark.user = current_user

    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark was saved successfully."
      redirect_to @topic
    else 
      flash[:error] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def edit
   
   @bookmark = Bookmark.find(params[:id])

   authorize @bookmark
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    name = @bookmark.url

    authorize @bookmark

    if @bookmark.update_attributes(bookmark_params)
      new_name = @bookmark.url 
      flash[:notice] = "\"#{name}\" is now \"#{new_name}\"."
      redirect_to topics_path
    else
      flash[:error] = "Error updating bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    name = @bookmark.url

    authorize @bookmark

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
