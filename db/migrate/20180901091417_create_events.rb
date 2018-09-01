class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :address
      t.datetime :start_at
      t.datetime :end_at
      t.string :image_url
      t.string :description

      t.timestamps
    end
  end
end
