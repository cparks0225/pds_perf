class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    # @queries = Query.all
    # gon.rabl :template => "app/views/queries/index.json.rabl"
    gon.rabl
    @query = Query.first
    gon.rabl "app/views/queries/show.json", as: "query"
  end
end
