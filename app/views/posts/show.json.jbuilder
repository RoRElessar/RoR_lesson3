json.extract! @post, :id, :title, :body, :tags
json.created_by @post.user.name
