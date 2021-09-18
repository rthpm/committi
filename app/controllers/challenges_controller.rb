class ChallengesController < ApplicationController
  include ApplicationHelper
  include ChallengesHelper
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :has_rights?, only: [:edit, :update, :destroy]
  before_action :ownership, only: [:edit, :update, :destoy]

  def show
    @statuses = @challenge.statuses
    @status = Status.new
    @comment = Comment.new
    if signed_in?
      @enrollment = current_user.enrollments.find_by(challenge: @challenge)
    end
    if @challenge.interval == "daily"
      @countdown = countdown_string
    else
      @countdown = countdown_string(@challenge.next_date)
    end
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @category = Category.find_by(slug: params[:category])
    @challenge = Challenge.create(user: current_user,
                                  title: params[:title],
                                  subtitle: params[:subtitle],
                                  description: params[:description],
                                  category: @category,
                                  interval: params[:interval],
                                  next_date: params[:next_date])
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

  def set_categories
    @categories = Category.all
  end

  def ownership
    return true if current_user.is_admin
    if current_user != @challenge.user
      redirect_back fallback_location: root_path,
                    alert: 'Vous ne pouvez pas faire cela'
    end
  end

private

  def challenge_params
    params.require(:challenge).permit(:title, :subtitle, :description, :category_slug)
  end
end
