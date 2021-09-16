class CategoriesController < ApplicationController
  before_action :set_categories
  def index
    @challenges = Challenge.all
  end

  def show
    @category = Category.find_by(slug: params[:slug])
    @challenges = @category.challenges
  end

  def set_categories
    @categories = Category.all
  end
end
