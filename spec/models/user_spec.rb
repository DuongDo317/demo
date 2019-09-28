require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User associations" do
    it { is_expected.to have_many(:user_infos) }
    it { is_expected.to have_many(:user_histories) }
  end

  it { should enumerize(:status).in(deactivate: 0, active: 1) }
end
