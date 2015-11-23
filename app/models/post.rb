class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  default_scope -> {order('created_at DESC')}
  validates_presence_of :title, :body, :user
  validates :title, length: { in: 5..140}
  validates :body, length: {minimum: 140}
 # validates :tag_list, uniqueness: true
  validates :user_id, presence: true

  has_reputation :votes,
      source: :user,
      aggregated_by: :sum

  acts_as_taggable

  def self.search(search)
    where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%")
  end

end

