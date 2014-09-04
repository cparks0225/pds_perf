@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.PdsApi extends Entities.Model
    urlRoot: -> Routes.pds_apis.path() #"http://pds-dev.debesys.net/api/1/api-docs"

  class Entities.PdsApiCollection extends Entities.Collection
    model: Entities.PdsApi

    url: -> Routes.pds_apis.path() #"http://pds-dev.debesys.net/api/1/api-docs"

  API =
    getPdsApi: ->
      pdsapi = new Entities.PdsApiCollection
      pdsapi.fetch
        reset: true
      pdsapi

    getPdsApi: (id) ->
      pdsapi = new Entities.PdsApi
        id: id
      pdsapi.fetch()
      pdsapi

    newPdsApi: ->
      new Entities.PdsApi

  App.reqres.setHandler "pdsapi:entities", ->
    API.getPdsApi()

  App.reqres.setHandler "pdsapi:entity", (id) ->
    API.getPdsApi id
  
  App.reqres.setHandler "new:pdsapi:entity", ->
    console.log "new pdsapi"
    API.newPdsApi()
