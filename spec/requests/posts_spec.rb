require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:posts) { create_list(:post, 10) }
  let!(:post_id) { posts.first.id }

  # Test for GET /posts
  describe 'GET /posts' do
    before { get '/posts' }

    it 'returns posts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200) # OK
    end
  end

  # Test for GET /posts/:id
  describe 'GET /posts/:id' do
    before { get "/posts/#{post_id}" }

    context 'when the record exists' do
      it 'returns the post' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200) # OK
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 20 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404) # Not Found
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test for POST /posts
  describe 'POST /posts' do
    let(:valid_attributes) { { title: 'foo', body: 'bar' } }

    context 'when the request is valid' do
      before { post '/posts', params: valid_attributes }

      it 'creates a post' do
        expect(json['title']).to eq('foo')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201) # Created
      end
    end

    context 'when the request is invalid' do
      before { post '/posts', params: { title: 'foo' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422) # Unprocessable Entity
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Body can't be blank/)
      end
    end
  end

  # Test for PUT /posts/:id
  describe 'PUT /posts/:id' do
    let(:valid_attributes) { { title: 'foo' } }

    context 'when the record exists' do
      before { put "/posts/#{post_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204) # No Content
      end
    end
  end

  # Test for DELETE /posts/:id
  describe 'DELETE /posts/:id' do
    before { delete "/posts/#{post_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204) # No Content
    end
  end
end
