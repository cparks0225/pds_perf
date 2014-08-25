@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Query extends Entities.Model

  class Entities.QueriesCollection extends Entities.Collection
    model: Entities.Query
    url: -> Routes.queries_path()

  API =
    setCurrentQuery: (currentQuery) ->
      new Entities.Query currentQuery

    getQueryEntities: (cb) ->
      queries = new Entities.QueriesCollection
      queries.fetch
        success: ->
          cb queries

  App.reqres.setHandler "set:current:query", (currentQuery) ->
    API.setCurrentQuery currentQuery

  App.reqres.setHandler "query:entities", (cb) ->
    API.getQueryEntities cb