module Api
  module V1
    class UsersController < ApplicationController
      before_action :find_user, only: :show
      def index
        @users = User.page(params[:page]).per(Settings.per_page.user)
        represent_response @users
      end

      def show
        histories = UserHistoryPresenter.new(@user.user_histories)
        info = UserInfoPresenter.new(@user.user_infos)
        response = { id: @user.id, name: @user.name, info: info, histories: histories }
        represent_response response
      end

      def 

      private

      def find_user
        @user = User.find(params[:id])
      end
    end
  end
end
