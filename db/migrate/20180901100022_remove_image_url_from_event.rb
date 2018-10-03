class RemoveImageUrlFromEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :image_url, :string
  end
end
