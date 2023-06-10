require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'initialize' do
    before(:each) do
      @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      @post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post')
      @comment = Comment.new(post_id: @post.id, author_id: @user.id, text: 'This is my first comment')
    end

    it 'should be a Comment' do
      expect(@comment).to be_a(Comment)
    end

    it 'should have the attributes' do
      expect(@comment).to have_attributes(author_id: @user.id, post_id: @post.id,
                                          text: 'This is my first comment')
    end
  end
end
