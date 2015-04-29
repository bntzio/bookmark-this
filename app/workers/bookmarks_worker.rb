class BookmarksWorker
  include Sidekiq::Worker

  require 'embedly'
  require 'json'

  def display(url)
    embedly_api = Embedly::API.new :key => ENV['EMBEDLY_API_KEY']
    obj = embedly_api.oembed :url => url
    obj.first
  end

  def perform(bookmark_id)
    bookmark = Bookmark.find(bookmark_id)
    bookmark_url = bookmark.url
    title = display(bookmark_url).title
    image = display(bookmark_url).thumbnail_url
    bookmark.update_attributes(title: title, image: image)
  end
end