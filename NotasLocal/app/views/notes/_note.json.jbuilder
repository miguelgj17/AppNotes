json.extract! note, :id, :title, :text, :image, :user_id, :created_at, :updated_at
json.url note_url(note, format: :json)
