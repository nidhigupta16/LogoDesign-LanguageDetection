class LogoDesignSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :user_id, :filename, :filesize, :is_active, :url, :user_logos

  def url
    rails_blob_path(object.file, only_path: true) if object.file.attached?
  end
end