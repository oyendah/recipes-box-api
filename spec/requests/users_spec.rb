require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe V1::UsersController, type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end
  let(:headers) { valid_headers }
  let(:user_id) { user.id }

  # User signup test suite
  describe 'POST /signup' do
    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message']).to match([
          'Validation failed: Password can\'t',
          'be blank, First name can\'t be blank, Last name can\'t be blank,',
          'User name can\'t be blank, Email can\'t be blank,',
          'Password digest can\'t be blank'
        ].join(' '))
      end
    end
  end

  # Test suite for GET /users
  describe 'GET /users' do
    # make HTTP get request before each example
    before { get '/users', params: {}, headers: headers }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /users/:id' do
    before { get "/users/#{user_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /users/:id' do
    let(:valid_attributes) { { first_name: 'Subayr' }.to_json }

    context 'when the record exists' do
      before do
        put "/users/#{user_id}", params: valid_attributes, headers: headers
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
