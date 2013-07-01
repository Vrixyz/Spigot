class Post < ActiveRecord::Base
  attr_accessible :title, :content

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true

  validates :content, presence: true

  default_scope order: 'posts.created_at DESC'
  
  self.per_page = 5;

  def position(column = 'id', order = 'ASC')
    order_by = "#{column} #{order}"
    arrow = order.capitalize == "ASC" ? "<=" : ">="
    Post.where("#{column} #{arrow} (?)", self.send(column)).order(order_by).count
  end
end
