class PortfoliosController < ApplicationController
  def index
  end

  def show
    @portfolio = Portfolio.find(params[:id])
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user_id = current_user.id
    if @portfolio.save
      redirect_to portfolio_path(@portfolio), notice: "ポートフォリオを投稿しました。"
    else
      render :new
    end
  end

  def edit
  end

  private
  def portfolio_params
    params.require(:portfolio).permit(:title, :body, :image, :comment)
  end
end
