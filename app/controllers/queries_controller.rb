class QueriesController < ApplicationController
  respond_to :json

  def index
    sleep 3
    @queries = nil #Query.all
  end
end