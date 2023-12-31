class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true, length: { maximum: 100 }
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def recent_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end

  def admin?
    role == 'admin'
  end
end
