require 'rails_helper'

RSpec.describe UserHistory, type: :model do
  describe "UserHistory associations" do
    it { is_expected.to belong_to(:user) }
  end
end
