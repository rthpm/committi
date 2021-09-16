class StatusesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_status, only: [:edit, :update, :destroy]
  before_action :has_rights?, only: [:edit, :update, :destroy]
  before_action :ownership, only: [:edit, :update, :destoy]

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

  def destroy
    @status.destroy
    flash[:notice] = 'Status effacé'
    redirect_to challenge_path(@challenge.slug)
  end

  def set_status
    @status = Status.find(params[:id])
    @challenge = @status.challenge
  end

  def ownership
    return true if current_user.is_admin
    if current_user != @status.user
      redirect_back fallback_location: root_path,
                    alert: 'Vous ne pouvez pas faire cela'
    end
  end

private

  def status_params
    params.require(:status).permit(:content, :user, :challenge)
  end
end
