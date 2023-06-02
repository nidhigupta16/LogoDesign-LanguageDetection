ActiveAdmin.register LogoDesign, as: "logo_designs_details " do
	permit_params :filename, :filesize, :user_email, :file
 	
	index do
		selectable_column
		id_column
		column :filename
		column :filesize
		column :user_email do |logo|
							logo.user.email
						end		
		column :file do |logo|
							if logo.file.present?
								image_tag logo.file, size: '100x100'
							else
								"No Image"
							end
						end
		actions
	end
end