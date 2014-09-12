class SystemsController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    @systems = System.all
  end

  def show
    @system = System.find params[:id]
  end
  
  def update
    @system = System.find params[:id]
    if @system.update_attributes(params[:system].permit(:name) )
      render "systems/show"
    else
      respond_with @system
    end
  end
  
  def create
    @system = System.new
    if @system.update_attributes(params[:system].permit(:name) )
      render "systems/show"
    else
      respond_with @system
    end
  end
  
  def destroy
    system = System.find params[:id]
    system.destroy()
    render json: {}
  end
  
end