require 'rails_helper'

RSpec.describe 'Recipe Categories API' do
  let(:user) { create(:user) }
  let!(:recipe_category) { create(:recipe_category) }
  let(:headers) { valid_headers }
  let(:id) { recipe_category.id }

  describe 'GET /recipe_categories' do
    # make HTTP get request before each example
    before { get '/recipe_categories', params: {}, headers: headers }

    it 'returns recipe categories' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /recipe_categories/:id' do
    # make HTTP get request before each example
    before { get "/recipe_categories/#{id}", params: {}, headers: headers }

    it 'returns recipe category' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['name']).to eq('baking')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /recipe_categories' do
    let(:valid_attributes) { { name: 'American' }.to_json }

    context 'when the record exists' do
      before do
        post '/recipe_categories', params: valid_attributes, headers: headers
      end

      it 'created the record' do
        # binding.pry
        expect(json).not_to be_empty
        expect(json['recipe_category']['name']).to eq('American')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /recipe_categories/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do
      put "/recipe_categories/#{id}", params: valid_attributes,
                                      headers: headers
    end

    context 'when recipe exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the recipe' do
        updated_recipe_category = RecipeCategory.find(id)
        expect(updated_recipe_category.name).to match(/Mozart/)
      end
    end

    context 'when the recipe category does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find RecipeCategory/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /recipe_categories/:id' do
    before do
      delete "/recipe_categories/#{id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
