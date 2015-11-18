class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  default_scope -> {order('created_at DESC')}
  validates_presence_of :title, :body, :tags, :user
  validates :title, length: { in: 5..140}
  validates :body, length: {minimum: 140}
  validates :tags, uniqueness: true
  validates :user_id, presence: true

  has_reputation :votes,
      source: :user,
      aggregated_by: :sum

  def self.search(search)
    where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%")
  end

end

