require 'rails_helper'

RSpec.describe Userlanguage, type: :model do
  describe "Associations" do
     it { should belong_to(:user) }
     it { should belong_to(:language) }
  end
end