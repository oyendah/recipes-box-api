require 'rails_helper'

RSpec.describe 'Recipes API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:recipes) { create_list(:recipe, 10, user_id: user.id) }
  let(:id) { recipes.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /recipes
  describe 'GET /recipes' do
    # make HTTP get request before each example
    before { get '/recipes' }

    it 'returns recipes' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /recipe/:id
  describe 'GET /recipes/:id' do
    before { get "/recipes/#{id}" }

    context 'when the record exists' do
      it 'returns the recipe' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end
end
