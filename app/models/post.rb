class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> {order('created_at DESC')}
  validates :user, presence: true
  validates_presence_of :title, :body, :tags
  validates :title, length: { in: 5..100}
  validates :tags, uniqueness: true
  validates :user_id, presence: true

  def self.search(search)
    where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%")
  end

end

