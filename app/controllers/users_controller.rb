class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :profile, :update, :destroy,
                                  :update_email_and_password, :update_profile,]

  def show
    @user = User.find_by(username: params[:username])
  end

  def edit; end

  def profile; end

  def update_profile 
    if @user.update(profile_params)
      redirect_to profile_path(@user.username)
    else
      render :profile
    end
  end

  def update_email_and_password
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to profile_path(@user.username)
    else
      render :edit
    end
  end

  def destroy; end

  def set_user
    @user = current_user
  end

private

  def profile_params
    params.require(:user).permit(:username, :bio)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end
