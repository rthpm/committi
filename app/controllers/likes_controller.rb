class LikesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @user = current_user
    @status = params[:status_id]
    @like = Like.create!(status_id: @status, user: @user) unless liked?(@status, @user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @status = Status.find(params[:status_id])
    @like = @status.likes.find(params[:id])
    @like.delete
    redirect_back(fallback_location: root_path)
  end
end
