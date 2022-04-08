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
    @portfolio = current_user.portfolios.build(portfolio_params)
    if @portfolio.save
      redirect_to portfolio_path(@portfolio), notice: "ポートフォリオを投稿しました。"
    else
      render :new
    end
  end

  def edit
  end
end
