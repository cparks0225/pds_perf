class QueriesController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    @queries = Query.all
  end

  def show
    @query = Query.find params[:id]
  end

  def create
    @query = Query.new
    Rails.logger.debug( "SAVING QUERY" )
    Rails.logger.debug( params )
    @query.url = params[:url]
    @query.method = params[:url]
    @query.data = params[:data]
#    if @query.update_attributes(params[:query].permit(:url, :method, :data) )
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