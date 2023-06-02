require 'rails_helper'

RSpec.describe LogoDesignsController, type: :controller do
  let(:jwt_token) { JsonWebToken.encode(user_id: user.id) }
	let(:user) { FactoryBot.create(:user) }
 	let(:logo) { FactoryBot.create(:logo_design, user: user) }
	before do
		request.headers['Authorization'] = "Bearer #{jwt_token}"
	end

  describe 'GET #index' do
		it 'returns http success' do
			get :index
			expect(response).to have_http_status(:success)
		end
 	end

  describe "GET #show" do
		it "returns a success response" do
			get :show, params: { id: logo.id }
			expect(response).to have_http_status(:ok)
		end

		it 'set language when passing wrong params' do
			get :show, params: { id: 55 }
			expect(response).to have_http_status(:not_found)
		end
  end 

  describe "POST #create" do
		let(:base_64_data) { "data:image/jpg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDA...<truncated>" }
		let(:params) { { base_64: true, logo: { data: base_64_data }, user_id: logo.id, filename: "java.png" } }
		let(:logo_design_params) { { name: "Test Logo Design" } }

		it 'Logodesign create with' do 
			post :create, params: { id: logo.id }
			expect(response.status).to eq 422
		end	

		it "creates a new logo design with file attachment" do
			post :create, params: { logo_design: logo_design_params, **params }
			expect(response).to have_http_status(:ok)
		end
  end

	describe "PUT #update" do
    it "returns a success response" do
			@logo_design = logo 
			put :update, params: { id: @logo_design.id }
			expect(response).to have_http_status(:ok)
    end
  end

	describe 'destroy' do   
		it 'return a success response' do
			@logo_design = logo  
			delete :destroy, params: { id: @logo_design.id }
			expect(response).to have_http_status(:ok)
		end
 	end
end