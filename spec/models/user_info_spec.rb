require 'rails_helper'

RSpec.describe UserInfo, type: :model do
  describe "UserInfo associations" do
    it { is_expected.to belong_to(:user) }
  end
end
