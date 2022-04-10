class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @portfolio = Portfolio.find(params[:portfolio_id])
    @reviews = @portfolio.reviews
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to portfolio_reviews_path(@review.portfolio)
    else
      @portfolio = Portfolio.find(params[:portfolio_id])
      render "portfolios/show"
    end
  end

  private
  def review_params
    params.require(:review).permit(:portfolio_id, :score, :content)
  end
end
