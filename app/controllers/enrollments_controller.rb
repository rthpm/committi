class EnrollmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @user = current_user
    @challenge = Challenge.find(params[:challenge_slug])
    if helpers.enrolled?(@challenge, @user)
      flash[:notice] = 'Vous ne pouvez rejoindre un challenge plusieurs fois'
    else
      @enrollment = Enrollment.create!(challenge: @challenge, user: @user)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    @enrollment.delete
    redirect_back(fallback_location: root_path)
  end
end
