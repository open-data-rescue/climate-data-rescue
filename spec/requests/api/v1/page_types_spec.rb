require 'rails_helper'

RSpec.describe Api::V1::PageTypesController, type: :request do

  let(:user) { create(:user, :confirmed) }

  let(:valid_data) do
    {
      data: {
        type: 'page_types',
        attributes: {
          title: '1491_120_11_1879-07-01_1879-07-03_1.jpg'
        }
      }
    }
  end

  let(:invalid_data) do
    {
      data: {
        type: 'page_types',
        attributes: {
          title: ''
        }
      }
    }
  end

  # Test suite for #index
  describe 'GET /api/v1/page_type' do
    context 'user has an account' do
      before do
        login(user)
      end

      it 'returns status 200' do
        get api_v1_page_types_path

        expect(response).to have_http_status(200)
      end
    end

    context 'user does not have an account' do
      it 'returns status 302 (redirect to login)' do
        get api_v1_page_types_path

        expect(response).to have_http_status(302)
      end
    end
  end
end
