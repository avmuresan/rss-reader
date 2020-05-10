class AddFeedUrlUniqueIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :feeds, :url, unique: true
  end
end
