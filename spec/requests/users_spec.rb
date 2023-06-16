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

      it 'includes the correct placeholder text in the response body' do
        get '/users'
        expect(response.body).to include('Here is a list of users')
      end
  end

  describe 'GET show' do
    # Add your examples for the show action in UsersController
  end
end
