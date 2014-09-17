class EnvironmentsController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    if current_system().nil?
      @environments = []
    else
      @environments = []
      Environment.where("system=?", current_system().id ).all.each do |e|
        if current_environment().nil?
          e[:active] = false
        else
          if e[:id] == current_environment().id
            e[:active] = true
          else
            e[:active] = false
          end
        end
        @environments.push(e)
      end
    end
  end

  def show
    @environment = Environment.find params[:id]
    if current_environment().nil?
      @environment[:active] = false
    else
      if @environment[:id] == current_environment().id
        @environment[:active] = true
      else
        @environment[:active] = false
      end
    end
  end
  
  def update
    @environment = Environment.find params[:id]
    if params[:active]
      cookies[:environment] = params[:environment][:id]
    end
    if @environment.update_attributes(params[:environment].permit(:name, :riskapi, :pds, :active) )
      render "environments/show"
    else
      respond_with @environment
    end
  end
  
  def create
    @environment = Environment.new
    @environment.system = current_system().id
    if params[:active]
      cookies[:environment] = params[:environment][:id]
    end
    if @environment.update_attributes(params[:environment].permit(:name, :riskapi, :pds, :active) )
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