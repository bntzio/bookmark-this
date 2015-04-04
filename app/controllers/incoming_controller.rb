class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.find_by(email: params[:sender])
    @topic = Topic.create(title: params[:subject], user_id: @user.id)
    @url = params["body-plain"]
    @bookmark = Bookmark.create(url: @url, topic_id: @topic.id)

    puts "#{@user}, #{@topic}, #{@url}"

    head 200
  end
end