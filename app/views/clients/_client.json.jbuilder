json.extract! client, :id, :name, :email, :status, :assigned_to_id, :created_at, :updated_at
json.url client_url(client, format: :json)
