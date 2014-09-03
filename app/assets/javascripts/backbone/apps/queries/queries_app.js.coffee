@PdsPerf.module "QueryApp", (QueryApp, App, Backbone, Marionette, $, _) ->

  class QueryApp.Router extends Marionette.AppRouter
    appRoutes:
      "queries" : "listQueries"

  API =
    listQueries: ->
      QueryApp.List.Controller.listQueries()

    deleteQuery: (query) ->
      console.log "DELETE THIS QUERY" 
      console.log query
      query.destroy()

  App.vent.on "queries:delete:clicked", (query) ->
    API.deleteQuery query

  App.addInitializer ->
    new QueryApp.Router
      controller: API