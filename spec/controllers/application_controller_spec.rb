# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # create test user
  let!(:user) { create :user }
  # set headers for authorization
  let(:headers) { { Authorization: token_generator(user.id) } }
  let(:invalide_headers) { { Authorization: nil } }

  describe '#authorize_request' do
    context 'when auth token is passed' do
      before { allow(request).to receive(:headers).and_return headers }

      # private method authorize_request returns current user
      it 'should sets the current user' do
        expect(subject.instance_eval { authorize_request }).to eq user
      end
    end

    context 'when auth token is not passed' do
      before { allow(request).to receive(:headers).and_return invalide_headers }

      it 'should raises MissingToken error' do
        expect { subject.instance_eval { authorize_request } }
          .to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end
