require 'rails_helper'

RSpec.describe LogoDesign, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
  end
end
