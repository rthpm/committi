class StatusesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status, only: [:edit, :update, :destroy]

  def new
    @status = Status.new
  end

  def create
    @challenge = Challenge.find(params[:challenge_slug])
    @status = @challenge.statuses.build(status_params)
    @status.challenge = @challenge
    @status.user = current_user
    if @status.save!
      redirect_to challenge_path(@challenge.slug), notice: 'Votre status a été envoyé.'
    else
      redirect_back fallback_location: root_path, alert: 'Votre status n’a pas pu être envoyé.'
    end
  end

  def edit; end

  def update
    if @status.update(status_params)
      flash[:notice] = 'Status modifié'
      redirect_to challenge_path(@challenge.slug)
    else
      flash[:alert] = 'Votre status n’a pas pu être modifié'
      render :edit
    end
  end

  def set_status
    @status = Status.find(params[:id])
    @challenge = @status.challenge
  end

  def destroy
    @status.destroy
    flash[:notice] = 'Status effacé'
    redirect_to challenge_path(@challenge.slug)
  end

private

  def status_params
    params.require(:status).permit(:content, :user, :challenge)
  end
end
