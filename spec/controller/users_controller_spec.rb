require "rails_helper"

RSpec.describe Api::V1::User, type: :request do
  let!(:user) { create :user }
  let!(:user_info) { create(:user_info, user: user) }
  let!(:user_his) { create(:user_history, user: user) }
  describe "GET /api/v1/user" do
    let!(:users) { create_list :user, 6 }
    context "when not have page params" do
      before do
        get "/api/v1/users"
      end
      it "result success" do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data].count).to eq(5)
      end
    end

    context "when page don't have any data" do
      before do
        get "/api/v1/users", params: { page: 3 }
      end
      it "result success" do
        expect(response.body).to eq({
          "status": true,
          "data": []
        }.to_json)
      end
    end

    context "when page have data" do
      before do
        get "/api/v1/users", params: { page: 2 }
      end
      it "result success" do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data].count).to eq(2)
      end
    end
  end

  describe "GET /api/v1/user/id" do
    context "when user not exist" do
      before do
        get "/api/v1/users/0"
      end
      it "result record not found" do
        expect(response.body).to eq({
          "status": false,
          "error": {
            "error_code": 404,
            "message": "Record Not Found",
            "errors": "Couldn't find User with 'id'=0"
          }
        }.to_json)
      end
    end

    context "when user exist" do
      before do
        get "/api/v1/users/#{user.id}"
      end
      it "result success" do
        expect(response.body).to eq({
          "status": true,
          "data": {
            "id": user.id,
            "name": user.name,
            "info": [
              {
                "description": user_info.description,
                "email": user_info.email,
                created_at: user_info.created_at,
                updated_at: user_info.updated_at
              }
            ],
            "histories": [
              {
                action: user_his.action,
                created_at: user_his.created_at,
                updated_at: user_his.updated_at
              }
            ]
          }
        }.to_json)
      end
    end
  end

  describe "PATCH /api/v1/change_user_status" do
    context "when user not exist" do
      before do
        patch "/api/v1/change_user_status", params: {id: 0, status: 1}
      end
      it "result record not found" do
        expect(response.body).to eq({
          "status": false,
          "error": {
            "error_code": 404,
            "message": "Record Not Found",
            "errors": "Couldn't find User with 'id'=0"
          }
        }.to_json)
      end
    end

    context "when deactivate user" do
      let(:user_active) { create :user }
      before do
        patch "/api/v1/change_user_status", params: {id: user_active.id, status: 0}
      end
      it "result success" do
        expect(response.body).to eq({
          "status": true,
          "data": {
            "status": User.status.deactivate,
            "id": user_active.id,
            "name": user_active.name,
            "created_at": user_active.created_at,
            "updated_at": user_active.updated_at
          }
        }.to_json)
        expect(user_active.user_histories.count).to eq(1)
      end
    end

    context "when active user" do
      let(:user_deactivate) { create :user, status: 0 }
      before do
        patch "/api/v1/change_user_status", params: {id: user_deactivate.id, status: 1}
      end
      it "result success" do
        expect(response.body).to eq({
          "status": true,
          "data": {
            "status": User.status.active,
            "id": user_deactivate.id,
            "name": user_deactivate.name,
            "created_at": user_deactivate.created_at,
            "updated_at": user_deactivate.updated_at
          }
        }.to_json)
        expect(user_deactivate.user_histories.count).to eq(1)
      end
    end

    context "when user not update_status" do
      let(:user_active) { create :user }
      before do
        patch "/api/v1/change_user_status", params: {id: user_active.id, status: 1}
      end
      it "result success" do
        expect(response.body).to eq({
          "status": true,
          "data": {
            "status": User.status.active,
            "id": user_active.id,
            "name": user_active.name,
            "created_at": user_active.created_at,
            "updated_at": user_active.updated_at
          }
        }.to_json)
        expect(user_active.user_histories.count).to eq(0)
      end
    end

    context "when status not exist" do
      before do
        patch "/api/v1/change_user_status", params: {id: user.id, status: "aaaa"}
      end
      it "result record not found" do
        expect(response.body).to eq({
          "status": false,
          "error": {
            "error_code": 400,
            "message": "Record Invalid",
            "errors": "Status is not included in the list"
          }
        }.to_json)
      end
    end
  end
end
