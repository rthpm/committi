class StatusesController < ApplicationController
  before_action :authenticate_user!

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

private

  def status_params
    params.require(:status).permit(:content, :user, :challenge)
  end
end
