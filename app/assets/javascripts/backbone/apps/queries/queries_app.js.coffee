@PdsPerf.module "QueryApp", (QueryApp, App, Backbone, Marionette, $, _) ->

  class QueryApp.Router extends Marionette.AppRouter
    appRoutes:
      "queries" : "listQueries"

  API =
    listQueries: ->
      QueryApp.List.Controller.listQueries()

  App.addInitializer ->
    new QueryApp.Router
      controller: API