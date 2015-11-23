class RemoveTagsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :tags, :string
  end
end
