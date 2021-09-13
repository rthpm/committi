class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def show; end

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
