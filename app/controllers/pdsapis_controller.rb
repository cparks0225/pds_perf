require 'httpclient'
require 'json'

class PdsSerializer
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

# class PdsModel < PdsSerializer
#   attr_accessor :name, :description, :notes, :paramType, :defaultValue, :allowableValues, :required, :allowMultiple, :paramAccess, :internalDescription, :wrapperMenu, :dataType
# end

# class PdsParameter < PdsSerializer
#   attr_accessor :name, :description, :notes, :paramType, :defaultValue, :allowableValues, :required, :allowMultiple, :paramAccess, :internalDescription, :wrapperMenu, :dataType
# end

# class PdsOperation < PdsSerializer
#   attr_accessor :httpMethod, :summary, :notes, :deprecated, :responseClass, :nickname #, :parameters
# end

# class PdsApi < PdsSerializer
#   attr_accessor :swaggerVersion, :path, :description #, :operations
# end

class PdsApis < PdsSerializer
  attr_accessor :swaggerVersion, :basePath, :resourcePath, :apis, :models
end

class PdsService < PdsSerializer
  attr_accessor :path, :description, :apis, :models
end

def FetchApi(api)
  proxy = ENV['HTTP_PROXY']
  clnt = HTTPClient.new(proxy)
  clnt.set_cookie_store("cookie.dat")

  api_url_base = "http://pds-dev.debesys.net/api/1/api-docs/1/"
  api_url = api_url_base + api.path
  api_result = clnt.get(api_url)
  raw_api_json = JSON.parse(api_result.body)

  api_obj = PdsApis.new
  api_obj.from_json(JSON.generate(raw_api_json))

  api.apis = api_obj.apis
  api.models = api_obj.models
end

def StoreApis(file_name)
  proxy = ENV['HTTP_PROXY']
  clnt = HTTPClient.new(proxy)
  clnt.set_cookie_store("cookie.dat")

  service_url = current_environment().pds + "/api/1/api-docs"
  result = clnt.get(service_url)
  raw_json = JSON.parse(result.body)["apis"]
      
  api_url_base = current_environment().pds + "/api/1/api-docs/1/"

  @pds_apis = []
  for service in raw_json
    new_pds = PdsService.new
    new_pds.from_json(JSON.generate(service))

    new_pds.path = new_pds.path.split("\/")[4]
    FetchApi(new_pds)
    @pds_apis.push(new_pds)
  end
  File.open(file_name, 'w') {|f| f.write(YAML.dump(@pds_apis)) }
end

def LoadApis(file_name)
  apis = YAML.load(File.read(file_name))
  return apis
end

class PdsapisController < ApplicationController
  respond_to :json

  def index
    Rails.logger.debug( "CURRENT ENVIRONMENT" )
    Rails.logger.debug( current_environment().pds )
    Rails.logger.debug( params )

    file_name = current_environment().pds.gsub(/[^0-9A-Za-z]/, '') + ".yaml"

    # Refresh the store if necessary
    if not params[:refresh].nil?
      StoreApis(file_name)
    end

    # Create the store if necessary
    if File.exists?(file_name) == false
      StoreApis(file_name)
    end

    @pds_apis = LoadApis(file_name)
  end

  def show
    @pds_api = @pds_apis
  end
end
