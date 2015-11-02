class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :body, :tags
  validates :title, length: { in: 5..100}
  validates :tags, uniqueness: true
end
