require 'httpclient'
require 'json'
require 'base64'

require 'uri'
require 'net/http'
require 'net/https'

class AuthSerializer
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

class AuthService < AuthSerializer
  attr_accessor :id, :access_token #, :token_type, :expires_in, :refresh_token, :user_id, :person_id
end

def FetchAuthToken(username, password)
  access_token = nil
  clientId ='7acb772129644c4483f9944eec85476f'
  clientSecret ='417b19d133024e1e85e13133077cf7362de80f0f32e44a338383f0f7d0140f78'
  encodeValue = Base64.strict_encode64(clientId + ":" + clientSecret)
  full_url = "https://id.ttstage.com/oauth/token"

  url = URI.parse(full_url)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  data = "grant_type=password&username=" + username + "&password=" + password
  auth_header = 'Basic ' + encodeValue

  headers = {
    'Connection' => 'keep-alive',
    'Authorization' => auth_header,
    'Content-Type' => 'application/x-www-form-urlencoded'
  }

  resp = http.post(url.path, data, headers)

  if resp.msg == "OK"
    access_token = JSON.parse(resp.body)["access_token"]
    cookies[:auth_token] = access_token
  else
    err = JSON.parse(resp.body)["error_description"]
  end
  return access_token 
end

class AuthController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    ret = AuthService.new
    ret.from_json(current_auth_token())
    Rails.logger.debug( ret.to_json )
    @auths = [ret]
  end

  def show
    ret = AuthService.new
    ret.from_json(current_auth_token())
    Rails.logger.debug( ret.to_json )
    @auth = ret
  end

  def create
    new_token = FetchAuthToken( params[:username], params[:password] )
    ret = AuthService.new
    ret.from_json(JSON.generate({"id" => 1, "access_token" => new_token}))
    @auth = ret
    render "auth/show"
  end

  def destroy
    cookies[:auth_token] = nil
    render "auth/show"
  end
end
