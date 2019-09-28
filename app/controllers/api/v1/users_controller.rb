module Api
  module V1
    class UsersController < ApplicationController
      before_action :find_user, only: [:show, :change_user_status]
      def index
        @users = User.page(params[:page]).per(Settings.per_page.user)
        represent_response @users
      end

      def show
        histories = UserHistoryPresenter.new(@user.user_histories.last(5))
        info = UserInfoPresenter.new(@user.user_infos)
        response = { id: @user.id, name: @user.name, info: info, histories: histories }
        represent_response response
      end

      def change_user_status
        old_status = @user.status
        if params[:status].present?
          @user.update_attributes!(status: params[:status])
          history = I18n.t('api.v1.users.change_status', status: @user.status)
          @user.user_histories.create(action: history) if old_status != @user.status
        end
        represent_response @user
      end

      private

      def find_user
        @user = User.find(params[:id])
      end
    end
  end
end
