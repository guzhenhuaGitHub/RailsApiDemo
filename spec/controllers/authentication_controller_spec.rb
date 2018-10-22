# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  # Authentication test suite
  describe 'POST /auth/login' do
    # create test user
    let!(:user) { create :user }
    # set headers for authorization
    let(:headers) { valid_headers.except :Authorization }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }
    end

    # set request.headers to our custom headers
    # before { allow(request).to receive(:headers).and_return headers }

    # returns auth token when request is valid
    context 'when request is valid' do
      before do
        request.headers.merge! headers
        post :authenticate, params: valid_credentials
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'when request is invalid' do
      before do
        request.headers.merge! headers
        post :authenticate, params: invalid_credentials
      end

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end
