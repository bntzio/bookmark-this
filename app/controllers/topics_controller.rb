class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @topics = Topic.paginate(page: params[:page], per_page: 100)
  end

  def show
    @topic = Topic.friendly.find(params[:id])
    if request.path != topic_path(@topic)
      redirect_to @topic, status: :moved_permanently
    end
  end

  def new
    @topic = Topic.new

    authorize @topic
  end

  def create
    @topic = current_user.topics.new(topic_params)

    authorize @topic

    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else 
      flash[:error] = "There was an error saving the topic. Please try again."
      render :new
    end
  end


  def edit
    @topic = Topic.friendly.find(params[:id])

    authorize @topic
  end

  def update
    @topic = Topic.friendly.find(params[:id])
    name = @topic.title

    authorize @topic

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
    @topic = Topic.friendly.find(params[:id])
    name = @topic.title

    authorize @topic

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
