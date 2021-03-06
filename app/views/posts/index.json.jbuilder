json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :tag_list
  json.created_by post.user.name
  json.url post_url(post, format: :json)
end
