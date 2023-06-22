require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                     posts_counter: 0, email: 'example@example.com', password: 'password',
                     password_confirmation: 'password')
  end

  describe 'initialize' do
    it 'should be a User' do
      expect(@user).to be_a(User)
    end

    it 'should have the attributes' do
      expect(@user).to have_attributes(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                       bio: 'Teacher from Mexico.', posts_counter: 0, email: 'example@example.com',
                                       password: 'password', password_confirmation: 'password')
    end
  end

  describe 'validations' do
    before { @user.save }

    it 'should validate presence of name' do
      expect(@user).to be_valid
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'should validate numericality of posts_counter' do
      expect(@user).to be_valid
      @user.posts_counter = 'a'
      expect(@user).to_not be_valid
    end

    it 'should validate if posts_counter is greater than or equal to zero' do
      expect(@user).to be_valid
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end
  end

  describe 'methods' do
    it 'should return the most recent posts' do
      @user.save

      Post.create(author_id: @user.id, title: 'First Post', text: 'This is my first post')
      post2 = Post.create(author_id: @user.id, title: 'Second Post', text: 'This is my second post')
      post3 = Post.create(author_id: @user.id, title: 'Third Post', text: 'This is my third post')
      post4 = Post.create(author_id: @user.id, title: 'Fourth Post', text: 'This is my fourth post')

      expect(@user.recent_posts).to eq([post4, post3, post2])
    end

    it 'should return an empty array if the user has no posts' do
      user2 = User.create(name: 'Jane')

      expect(user2.recent_posts).to eq([])
    end
  end
end
