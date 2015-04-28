class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  require 'embedly'
  require 'json'
  
  def display(url)
    embedly_api = Embedly::API.new :key => ENV['EMBEDLY_API_KEY']
    obj = embedly_api.oembed :url => url
    obj.first
  end

  def create
    @user = User.find_by(email: params[:sender])
    @topic = Topic.find_by(title: params[:subject])

    @url = params["body-plain"]

    if @user.nil?
      @user = User.new(email: params[:sender], password: "temp0rary_passw0rd")
      @user.skip_confirmation!
      @user.save!
    end

    if @topic.nil?
      @topic = @user.topics.create(title: params[:subject])
    end

    @bookmark = @user.bookmarks.create(url: @url, topic_id: @topic.id)

    head 200
  end
end