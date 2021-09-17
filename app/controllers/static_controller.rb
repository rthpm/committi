class StaticController < ApplicationController
  def index
    @challenges = Challenge.all
    @categories = Category.all
  end
end
