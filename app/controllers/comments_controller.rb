class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @challenge = Challenge.find(params[:challenge_slug])
    @status = Status.find(params[:status_id])
    @comment = @status.comments.build(comment_params)
    @comment.status = @status
    @comment.user = current_user
    if @comment.save!
      redirect_to challenge_path(@challenge.slug), notice: 'Votre commentaire a été envoyé.'
    else
      redirect_back fallback_location: root_path, alert: 'Votre commentaire n’a pas pu être envoyé.'
    end
  end

private

  def comment_params
    params.require(:comment).permit(:content, :user, :status)
  end
end
