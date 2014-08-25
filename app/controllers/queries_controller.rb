class QueriesController < ApplicationController
  respond_to :json

  def index
    @queries = Query.all
  end
end