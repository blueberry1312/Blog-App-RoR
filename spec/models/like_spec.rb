require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        bio: 'Teacher from Mexico.', email: 'example@example.com',
                        password: 'password', password_confirmation: 'password')
    @post = Post.create(author_id: @user.id, title: 'Post 1', text: 'This is my first post')
  end

  describe 'initialize' do
    before(:each) do
      @like = Like.new(post_id: @post.id, author_id: @user.id)
    end

    it 'should be a Like' do
      expect(@like).to be_a(Like)
    end

    it 'should have the attributes' do
      expect(@like).to have_attributes(post_id: @post.id, author_id: @user.id)
    end
  end

  describe 'methods' do
    it 'should update the likes_counter of the post' do
      post_likes_counter = @post.likes_counter
      expect(post_likes_counter).to eq(0)

      Like.create(post: @post, author: @user)
      @post.reload
      post_likes_counter = @post.likes_counter
      expect(post_likes_counter).to eq(1)
    end
  end
end
