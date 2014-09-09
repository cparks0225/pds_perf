class ResultsController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    @results = Result.all
  end

  def show
    @result = Result.find params[:id]
  end

  def create
    @result = Result.new
    @result.url = params[:url]
    @result.method = params[:method]
    @result.data = params[:data]
    if @result.save
      render "results/show"
    else
      respond_with @result
    end
  end

  def destroy
    result = Result.find params[:id]
    result.destroy()
    render json: {}
  end
end