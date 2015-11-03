class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> {order('created_at DESC')}
  validates_presence_of :title, :body, :tags
  validates :title, length: { in: 5..100}
  validates :tags, uniqueness: true
  validates :user_id, presence: true
end
