require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET index' do
    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'returns a successful response' do
      get '/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show' do
    it 'renders the show template' do
      user = User.create(name: 'Test', photo: 'https://test.jpg', bio: 'test.', email: 'example@example.com',
                         password: 'password')
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'returns a successful response' do
      user = User.create(name: 'Test', photo: 'https://test.jpg', bio: 'test.', email: 'example@example.com',
                         password: 'password')
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
