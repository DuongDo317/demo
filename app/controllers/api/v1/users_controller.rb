module Api
  module V1
    class UsersController < ApplicationController
      before_action :find_user, only: :show
      def index
        @user = User.page(params[:page]).per(Settings.per_page.user)
        represent_response @user
      end

      def show
        represent_response @user
      end

      private

      def find_user
        @user = User.find(params[:id])
      end
    end
  end
end
