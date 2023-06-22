class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc)
    @current_user = current_user if user_signed_in?
  end

  def show
    @user = User.find(params[:id])
  end
end
