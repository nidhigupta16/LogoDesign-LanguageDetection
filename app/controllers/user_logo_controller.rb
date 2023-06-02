class UserLogoController < ApplicationController
	before_action :authorize_request 
	before_action :find_user_logo_id, :except => [:index, :create ]
 
  def index 
 		render json: @current_user.user_logos, each_serializer: UserLogoSerializer
 	end
	 
	def show
		render json: @user_logo, single_serializer: UserLogoSerializer
	end
    
	def create
		if params.has_key?(:base_64)
			a = { 
					io: StringIO.new(Base64.decode64(params[:logo][:data].split(',')[1])),
					content_type: 'image/jpeg',
					filename: params[:filename]
			}
			logo_design = UserLogo.new(user_logo_params)
			message = logo_design.file.attach(a) ? "file attached" : "file not attached"
		else
			logo_design = UserLogo.new(user_logo_params)
			logo_design.file.attach(params[:logo_design])
			logo_design.file = params[:logo_design]
		end

		if logo_design.save
			url = url_for(logo_design.file)
			render json: { message: message,logo: logo_design, url: url }, status: :ok
		else
			render json: { errors: logo_design.errors }, status: :unprocessable_entity
		end
  end
    
	def update
		@user_logo.file.attach(params[:logo_design])
		@user_logo.update(user_logo_params)
		render json: @user_logo, single_serializer: UserLogoSerializer
	end
		
	def destroy
		@user_logo.destroy 
		render json: {  message: "deleted"}
	end
    
	def find_user_logo_id
		@user_logo = UserLogo.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		render json: { errors: "Id #{params[:id]} not found" }, status: :not_found
	end

	private

	def user_logo_params
		params.permit(:user_id, :is_active, :logo_design_id, :created_by, :updated_by)
	end
end
