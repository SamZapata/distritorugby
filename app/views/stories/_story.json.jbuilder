json.extract! story, :id, :name, :summary, :body, :emb_video, :image, :image_caption, :video_caption, :created_at, :updated_at
json.url story_url(story, format: :json)
