class SearchController < ApplicationController

  def index
    @query = Company.includes(:owner).search(params[:q])
    @companies = @query.result.page(params[:page]).per(5)
  end

end
