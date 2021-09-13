class ChallengesController < ApplicationController
  include ApplicationHelper
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @challenges = Challenge.all
  end

  def show
    @statuses = @challenge.statuses
    @status = Status.new
    @comment = Comment.new
    @enrollment = @user.enrollments.find_by(challenge: @challenge)
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.create(user: current_user,
                                  title: params[:title],
                                  subtitle: params[:subtitle],
                                  description: params[:description])
    if @challenge.save
      flash[:notice] = 'Nouveau challenge créé'
      redirect_to challenge_path(@challenge.slug)
    else
      flash[:alert] = 'Impossible de créer ce challenge'
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  def set_challenge
    @challenge = Challenge.find_by(slug: params[:slug])
    @user = @challenge.user
    @user_path = profile_path(@user.username)
  end
end
