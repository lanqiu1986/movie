class ReviewsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @film = Film.find(params[:film_id])
    if current_user.is_favor_of?(@film)
      @review = Review.new
    else
      redirect_to film_path(@film)
    end
  end

  def create
    @film = Film.find(params[:film_id])
    @review = Review.new(review_params)
    @review.film = @film
    @review.user = current_user

    if @review.save
      redirect_to film_path(@film)
    else
      render :new
    end
  end


  private

  def review_params
    params.require(:review).permit(:content)
  end
end
