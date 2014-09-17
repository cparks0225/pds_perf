class SystemsController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    @systems = []
    System.all.each do |s|
      if current_system().nil?
        s[:active] = false
      else
        if s[:id] == current_system().id
          s[:active] = true
        else
          s[:active] = false
        end
      end
      @systems.push(s)
    end
  end

  def show
    @system = System.find params[:id]
    if current_system().nil?
      @system[:active] = false
    else
      if @system[:id] == current_system().id
        @system[:active] = true
      else
        @system[:active] = false
      end
    end
  end
  
  def update
    @system = System.find params[:id]
    if params[:active]
      cookies[:system] = params[:system][:id]
    end
    if @system.update_attributes( params[:system].permit(:name, :active) )
      render "systems/show"
    else
      respond_with @system
    end
  end
  
  def create
    @system = System.new
    if params[:active]
      cookies[:system] = params[:system][:id]
    end
    if @system.update_attributes( params[:system].permit(:name, :active) )
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