class ChallengesController < ApplicationController
  include ApplicationHelper
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :has_rights?, only: [:edit]

  def index
    @challenges = Challenge.all
  end

  def show
    @statuses = @challenge.statuses
    @status = Status.new
    @comment = Comment.new
    if signed_in?
      @enrollment = current_user.enrollments.find_by(challenge: @challenge)
    end
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

  def update
    if @challenge.update(challenge_params)
      flash[:notice] = 'Challenge modifié'
      redirect_to challenge_path(@challenge.slug)
    else
      flash[:alert] = 'Votre challenge n’a pas pu être modifié'
      render :edit
    end
  end

  def destroy
    @challenge.destroy
    flash[:notice] = 'Challenge effacé'
    redirect_to root_path
  end

  def set_challenge
    @challenge = Challenge.find_by(slug: params[:slug])
    @user = @challenge.user
    @user_path = profile_path(@user.username)
  end

private

  def challenge_params
    params.require(:challenge).permit(:title, :subtitle, :description)
  end
end
