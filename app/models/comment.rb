require_relative 'application_record'

class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  belongs_to :post, optional: true

  after_save :update_comment_counter

  private

  def update_comment_counter
    post.update(comments_counter: post.comments.count)
  end
end
