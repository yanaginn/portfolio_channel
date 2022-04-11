class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@users = User.all
		@portfolios = Portfolio.all
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Portfolio.search_for(@content, @method)
		end
	end
end