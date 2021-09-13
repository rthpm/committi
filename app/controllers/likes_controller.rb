class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @user = current_user
    @status = params[:status_id]
    if helpers.liked?(@status, @user)
      flash[:notice] = "Vous ne pouvez liker un status plusieurs fois"
    else
      @like = Like.create!(status_id: @status, user: @user)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Likes.find(params[:id])
    @like.delete
    redirect_back(fallback_location: root_path)
  end
end
