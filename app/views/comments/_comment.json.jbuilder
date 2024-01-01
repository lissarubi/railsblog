json.extract! comment, :id, :body, :article_id, :user_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
