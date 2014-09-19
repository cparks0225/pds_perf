require 'json'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_auth_token
    if cookies[:auth_token].nil?
      JSON.generate({"id" => 0, "access_token" => ""})
    else
      @_current_auth_token ||= cookies[:auth_token] &&
        JSON.generate({"id" => 1, "access_token" => cookies[:auth_token]})
    end 
  end

  def current_system
    @_current_system ||= cookies[:system] &&
      System.find_by(id: cookies[:system])
  end

  def current_environment
    @_current_environment ||= cookies[:environment] &&
      Environment.find_by(id: cookies[:environment])
  end

  def index
  end
end
