require 'rails_helper'

RSpec.describe Api::V1::PagesController, type: :request do

  let(:user) { create(:confirmed_user) }

  let(:valid_data) do
    {
      data: {
        type: 'pages',
        attributes: {
          title: '1491_120_11_1879-07-01_1879-07-03_1.jpg'
        }
      }
    }
  end

  let(:invalid_data) do
    {
      data: {
        type: 'pages',
        attributes: {
          title: ''
        }
      }
    }
  end

  # Test suite for #index
  describe 'GET /api/v1/pages' do
    context 'user has an account' do
      it 'returns status 200' do
        get api_v1_pages_path

        expect(response).to have_http_status(200)
      end
    end

    context 'user does not have an account' do
      # it 'returns status 403' do
      #   get api_v1_pages_path

      #   expect(response).to have_http_status(403)
      # end
    end
  end
end
