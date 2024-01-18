class AddPublishedToAlbums < ActiveRecord::Migration[7.1]
  def change
    add_column :albums, :published, :boolean
  end
end
