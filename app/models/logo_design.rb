class LogoDesign < ApplicationRecord
  belongs_to :user 
  has_many :user_logos

  has_one_attached :file
  
  before_save :set_file_attributes, if: :file_attached?

  private
  def set_file_attributes
    self.filename = file.filename.to_s
    self.filesize = file.byte_size
  end

  def file_attached?
    file.attached?
  end
end
