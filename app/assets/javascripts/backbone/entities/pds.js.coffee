@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.PdsApi extends Entities.Model
    urlRoot: -> Routes.pdsapis_path()

  class Entities.PdsApiCollection extends Entities.Collection
    model: Entities.PdsApi

    url: -> Routes.pdsapis_path()

  class Entities.PdsRestful extends Entities.Model
    urlRoot: -> Routes.pdsapis

  API =
    getPdsApis: ->
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
    API.getPdsApis()

  App.reqres.setHandler "pdsapi:entity", (id) ->
    API.getPdsApi id
  
  App.reqres.setHandler "new:pdsapi:entity", ->
    API.newPdsApi()
