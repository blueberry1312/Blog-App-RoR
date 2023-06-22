class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', optional: true
  has_many :comments
  has_many :likes

  validates :title, presence: { message: 'Title must not be blank.' }, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  after_save :update_posts_counter

  def recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
