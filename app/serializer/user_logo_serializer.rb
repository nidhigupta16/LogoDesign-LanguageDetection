class UserLogoSerializer < ActiveModel::Serializer
	include Rails.application.routes.url_helpers

	attributes :id, :user_id, :logo_design_id, :filename, :filesize, :is_active, :url, :logo_design

	def url
		rails_blob_path(object.file, only_path: true) if object.file.attached?
	end
end