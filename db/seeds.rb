require 'faker'

# Create Users
10.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Topics
50.times do
  Topic.create!(
      title: Faker::Lorem.word,
      user: users.sample
    )
end
topics = Topic.all

# Create Bookmarks
100.times do
  Bookmark.create!(
      url: Faker::Internet.url,
      topic: topics.sample
    )
end
bookmarks = Bookmark.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"