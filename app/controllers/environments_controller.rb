class EnvironmentsController < ApplicationController
  respond_to :json

  def index
    @environments = Environment.all
  end
end