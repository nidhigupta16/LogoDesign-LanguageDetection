class LogoDesignsController < ApplicationController
	before_action :authorize_request 
	before_action :find_logo_id, :except => [:index, :create]

  def index 
		@logos = LogoDesign.all
		# render json: @current_user.logo_design, each_serializer: LogoDesignSerializer
		render json: @logos, each_serializer: LogoDesignSerializer
	end

	def show
		render json: @logo, single_serializer: LogoDesignSerializer
 	end

	def create
		if params.has_key?(:base_64)
			a = { 
				io: StringIO.new(Base64.decode64(params[:logo][:data].split(',')[1])),
				content_type: 'image/jpeg',
				filename: params[:filename]
			}
			logo_design = LogoDesign.new(logo_design_params)
			message = logo_design.file.attach(a) ? "file attached" : "file not attached"
 		else
			logo_design = LogoDesign.new(logo_design_params)
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
		@logo.file.attach(params[:logo_design])
		@logo.update(logo_design_params)
 		render json: @logo, single_serializer: LogoDesignSerializer
  end
	  
	def destroy
		@logo.destroy 
		render json: {  message: " deleted "}
 	end

  def find_logo_id
		@logo = LogoDesign.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Id #{params[:id]} not found" }, status: :not_found
  end

	private
	def logo_design_params
		params.permit(:user_id, :is_active, :created_by, :updated_by)
	end
end
