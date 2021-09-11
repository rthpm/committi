class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_member!, only: [:new, :edit]

  def index
    @challenges = Challenge.all
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  def set_challenge
    @challenge = Challenge.find_by(slug: params[:slug])
    @user = @challenge.user
    @user_path = profile_path(@user.username)
  end
end
