class LikesController < ApplicationController

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      flash[:notice] = "Bookmark was liked!"
      redirect_to :back
    else
      flash[:error] = "There was an error liking the bookmark. Please try again later."
      redirect_to :back
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])

    if like.destroy
      flash[:notice] = "Bookmark was unliked."
      redirect_to :back
    else
      flash[:error] = "There was an error unliking the bookmark. Please try again later."
      redirect_to :back
    end
  end

end