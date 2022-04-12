class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		# @users = User.all
		# @portfolios = Portfolio.all
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		# if @model == 'user'
		# 	@records = User.search_for(@content, @method)
		# elsif @model == 'portfolio'
		# 	@records = Portfolio.search_for(@content, @method)
		# else
		# 	@records = Tag.search_portfolios_for(@content, @method)
		# end

		case @model
			when 'user'
			  @records = User.search_for(@content, @method)
			when 'portfolio'
			  @records = Portfolio.search_for(@content, @method)
			else
			  @records = Tag.search_portfolios_for(@content, @method)
		end
	end
end