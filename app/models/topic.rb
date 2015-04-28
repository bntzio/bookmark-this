class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 4, maximum: 32 }, presence: true
end
