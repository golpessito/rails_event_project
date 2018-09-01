json.extract! event, :id, :name, :address, :start_at, :end_at, :image_url, :description, :created_at, :updated_at
json.url event_url(event, format: :json)
