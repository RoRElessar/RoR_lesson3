class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates_presence_of :comment, :user
  validates :comment, length: {maximum: 200}
end
