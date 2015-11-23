json.extract! @post, :id, :title, :body, :tag_list
json.created_by @post.user.name
