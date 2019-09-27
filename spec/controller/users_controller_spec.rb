require "rails_helper"

RSpec.describe Api::V1::User, type: :request do
  let!(:user) { create :user }
  describe "GET /api/v1/user" do
    context "when not have page params" do
      before do
        get "/api/v1/users"
      end
      it "result success" do

      end
    end

    context "when page don't have any data" do
      before do
        get "/api/v1/users", params: { page: 1 }
      end
      it "result success" do

      end
    end

    context "when page have data" do
      before do
        get "/api/v1/users", params: { page: 3 }
      end
      it "result success" do

      end
    end
  end

  describe "GET /api/v1/user/id" do
    context "when user not exist" do
      before do
        get "/api/v1/users/0"
      end
      it "result record not found" do

      end
    end

    context "when user exist" do
      before do
        get "/api/v1/users/#{user.id}"
      end
      it "result success" do

      end
    end
  end

  describe "PATCH /api/v1/user/id" do
    context "when user not exist" do
      before do
        get "/api/v1/users/0"
      end
      it "result record not found" do

      end
    end

    context "when deactive user" do
      before do
        get "/api/v1/users/#{user.id}"
      end
      it "result success" do

      end
    end

    context "when active user" do
      before do
        get "/api/v1/users/#{user.id}"
      end
      it "result success" do

      end
    end
  end
end