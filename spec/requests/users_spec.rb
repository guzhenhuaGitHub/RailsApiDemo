# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build :user }
  let(:headers) { valid_headers.except :Authorization }
  let(:valid_attributes) do
    attributes_for :user, password_confirmation: user.password
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before do
        post '/signup', params: valid_attributes.to_json, headers: headers
      end

      it 'should creates a new user' do
        expect(response).to have_http_status 201
      end

      it 'should returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'should returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'should does not create a new user' do
        expect(response).to have_http_status 422
      end

      it 'should returns failure message' do
        keys = ['Password', 'Name', 'Email', 'Password digest']
        regex = /Validation failed: #{keys.map { |key| "#{key} can't be blank" }.join(', ')}/
        expect(json['message']).to match(regex)
      end
    end
  end
end
