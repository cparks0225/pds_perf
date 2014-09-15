class QueriesController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    if current_system().nil?
      @queries = []
    else
      @queries = Query.where("system=?", current_system().id )
    end
  end

  def show
    @query = Query.find params[:id]
  end

  def create
    @query = Query.new
    @query.url = params[:url]
    @query.method = params[:method]
    @query.data = params[:data]
    if @query.save
      render "queries/show"
    else
      respond_with @query
    end
  end

  def destroy
    query = Query.find params[:id]
    query.destroy()
    render json: {}
  end
end