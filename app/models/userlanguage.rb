class Userlanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language
end
