require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:each) do
      @user = User.create(name: 'Test', photo: 'https://test.jpg', bio: 'test.', email: 'example@example.com',
                          password: 'password')
      get user_posts_path(@user)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
  describe 'GET /show' do
    before(:each) do
      @user = User.create(name: 'Test', photo: 'https://test.jpg', bio: 'test.', email: 'example@example.com',
                          password: 'password')
      @post = Post.create(author_id: @user.id, title: 'test', text: 'test')
      get user_post_path(@user, @post)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
end
