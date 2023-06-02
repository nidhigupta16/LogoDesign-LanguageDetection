class User < ApplicationRecord
  has_one :userlanguage
  has_many :logo_design
  has_many :user_logos

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
