require 'json'

class SessionSerializer
  include ActiveModel::Serializers::JSON

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    instance_values
  end
end

class SessionService < SessionSerializer
  attr_accessor :id, :name, :session_id, :_csrf_token, :system, :environment, :page
end

def ConvertSessionData
  new_session = SessionService.new
  new_session.from_json(session.to_hash.to_json)
  return new_session
end

class SessionsController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    @session_var = [ConvertSessionData()]
  end

  def show
    @session_var = ConvertSessionData()
  end

  def update
    Rails.logger.debug( "SESSION UPDATE" )
    Rails.logger.debug( session[:system] )
    session[:id] = session["session_id"]
    params[:session].each do |key, val|
      if not val == nil
        session[key] = val
      else
        session[key] = session[key]
      end
    end
    @session_var = ConvertSessionData()
    Rails.logger.debug( "@session_var" )
    Rails.logger.debug( @session_var )
    Rails.logger.debug( "session" )
    Rails.logger.debug( session.to_hash )
    render "sessions/show"
  end

  def create
    Rails.logger.debug( "SESSION CREATE" )
    session[:id] = session["session_id"]
    params[:session].each do |key, val|
      if not val == nil
        session[key] = val
      else
        session[key] = session[key]
      end
    end
    @session_var = ConvertSessionData()
    Rails.logger.debug( "@session_var" )
    Rails.logger.debug( @session_var )
    Rails.logger.debug( "session" )
    Rails.logger.debug( session.to_hash )
    render "sessions/show"
  end
end
