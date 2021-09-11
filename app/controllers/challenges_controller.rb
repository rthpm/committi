class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  def index
    @challenges = Challenge.all
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  def set_challenge
    @challenge = Challenge.find_by(slug: params[:slug])
  end
end
