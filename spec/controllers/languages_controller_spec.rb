require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:jwt_token) { JsonWebToken.encode(user_id: user.id) }
	let(:language_params) { { language: 'English' } }

  describe 'GET #index' do
    context 'with a valid token' do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
    
    context 'without a token' do
      before { get :index }
      it 'returns http unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET #current_language' do
    context 'with a valid token' do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        get :current_language
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH #update_current_language' do
    let(:new_language) { FactoryBot.create(:language) }

    context 'with a valid token and language params' do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        patch :update_current_language, params: { language_id: new_language.id }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end 
    end

		context 'when there is an error' do
      before do
        allow_any_instance_of(Userlanguage).to receive(:update).and_raise(ActiveRecord::RecordInvalid)
      end

      it 'returns an unprocessable entity status' do
        put :update_current_language, params: language_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Some error occured!')
      end
		end
  end
end

