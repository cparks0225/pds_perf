class EnvironmentsController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    @environments = Environment.all
  end

  def show
    @environment = Environment.find params[:id]
  end
  
  def update
    @environment = Environment.find params[:id]
    if @environment.update_attributes(params[:environment].permit(:name, :riskapi, :pds) )
      render "environments/show"
    else
      respond_with @environment
    end
  end
  
  def create
    @environment = Environment.new
    if @environment.update_attributes(params[:environment].permit(:name, :riskapi, :pds) )
      render "environments/show"
    else
      respond_with @environment
    end
  end
  
  def destroy
    environment = Environment.find params[:id]
    environment.destroy()
    render json: {}
  end
  
end