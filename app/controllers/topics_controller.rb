class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else 
      flash[:error] = "There was an error saving the topic. Please try again."
      render :new
    end
  end


  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    name = @topic.title

    if @topic.update_attributes(topic_params)
      new_name = @topic.title 
      flash[:notice] = "\"#{name}\" is now \"#{new_name}\"."
      redirect_to @topic
    else
      flash[:error] = "Error updating topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.title

    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic. Please try again."
      render :show
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title)
  end
end
