@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Query extends Entities.Model
    urlRoot: -> Routes.queries_path()

  class Entities.QueriesCollection extends Entities.Collection
    model: Entities.Query

    url: -> Routes.queries_path()

  API =
    getQueries: ->
      queries = new Entities.QueriesCollection
      queries.fetch
        reset: true
      queries

    getQuery: (id) ->
      query = new Entities.Query
        id: id
      query.fetch()
      query

    newQuery: ->
      new Entities.Query

  App.reqres.setHandler "queries:entities", ->
    API.getQueries()

  App.reqres.setHandler "queries:entity", (id) ->
    API.getQuery id
  
  App.reqres.setHandler "new:queries:entity", ->
    API.newQuery()
