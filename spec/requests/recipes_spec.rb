require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Recipes API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let(:recipe_category) { create(:recipe_category) }
  let!(:recipes) do
    create_list(:recipe, 20, user_id: user.id,
                             recipe_category_id: recipe_category.id)
  end
  let(:user_id) { user.id }
  let(:id) { recipes.first.id }
  let(:headers) { valid_headers }
  let(:recipe_category_id) { recipe_category.id }

  # Test suite for GET /users/:user_id/recipes
  describe 'GET /users/:user_id/recipes' do
    before { get "/users/#{user_id}/recipes", params: {}, headers: headers }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user recipes' do
        expect(json.size).to eq(20)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /users/:user_id/recipes/:id
  describe 'GET /users/:user_id/recipes/:id' do
    before do
      get "/users/#{user_id}/recipes/#{id}", params: {}, headers: headers
    end

    context 'when user recipe exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the recipe' do
        expect(json['id']).to eq(id)
        expect(json['access']).to eq('can_access')
        expect(json['recipe_category_id']).to eq(recipe_category_id)
      end
    end

    context 'when user recipe does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/recipes
  describe 'POST /users/:user_id/recipes' do
    let(:valid_attributes) { { title: 'Eba', access: 1 }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/users/#{user_id}/recipes", params: valid_attributes,
                                          headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/recipes", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match([
          'Validation failed: Title can\'t be blank'
        ].join(' '))
      end
    end
  end

  # Test suite for PUT /users/:user_id/recipes/:id
  describe 'PUT /users/:user_id/recipes/:id' do
    let(:valid_attributes) { { title: 'Mozart', time_to_cook: '1 h' }.to_json }

    before do
      put "/users/#{user_id}/recipes/#{id}", params: valid_attributes,
                                             headers: headers
    end

    context 'when recipe exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the recipe' do
        updated_recipe = Recipe.find(id)
        expect(updated_recipe.title).to match(/Mozart/)
      end
    end

    context 'when the recipe does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before do
      delete "/users/#{user_id}/recipes/#{id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
