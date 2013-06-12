class Post < ActiveRecord::Base
  attr_accessible :title, :content

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true

  validates :content, presence: true

 default_scope order: 'posts.created_at DESC'
end
