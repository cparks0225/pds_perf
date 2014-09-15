class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_system
    @_current_system ||= cookies[:system] &&
      System.find_by(id: cookies[:system])
  end

  def index
  end
end
