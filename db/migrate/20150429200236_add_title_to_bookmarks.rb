class AddTitleToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :title, :string
  end
end
