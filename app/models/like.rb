class Like < ActiveRecord::Base
  belongs_to :bookmark
  belongs_to :user

  default_scope { order('created_at DESC') }
end
