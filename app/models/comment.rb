require_relative 'application_record'

class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post, optional: true

  after_save :update_comment_counter

  def author
    User.find(author_id)
  end

  private

  def update_comment_counter
    Post.find(post_id).update(comments_counter: Comment.where(post_id:).count)
  end
end
