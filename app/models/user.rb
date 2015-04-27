class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :topics, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end

  def self.top_rated
   self.select('users.*') # Select all attributes of the user
       .select('COUNT(DISTINCT bookmarks.id) AS bookmarks_count') # Count the bookmarks made by the user
       .select('COUNT(DISTINCT topics.id) AS topics_count') # Count the topics made by the user
       .select('COUNT(DISTINCT bookmarks.id) + COUNT(DISTINCT topics.id) AS rank') # Add the bookmark count to the topic count and label the sum as "rank"
       .joins(:topics) # Ties the topics table to the users table, via the user_id
       .joins(:bookmarks) # Ties the bookmarks table to the users table, via the user_id
       .group('users.id') # Instructs the database to group the results so that each user will be returned in a distinct row
       .order('rank DESC') # Instructs the database to order the results in descending order, by the rank that we created in this query. (rank = bookmark count + topic count)
   end

end
