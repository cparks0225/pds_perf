@PdsPerf.module "QueriesApp", (QueriesApp, App, Backbone, Marionette, $, _) ->

  class QueriesApp.Router extends Marionette.AppRouter
    appRoutes:
      "queries" : "listQueries"

  API =
    listQueries: ->
      console.log "queries_app:listQueries"
      new QueriesApp.List.Controller

    deleteQuery: (query) ->
      query.destroy()

    newQueryView: (region) ->
      new QueriesApp.New.Controller
        region: region
        
  App.vent.on "queries:delete:clicked", (query) ->
    API.deleteQuery query

  App.commands.setHandler "new:queries:query:view", (region) ->
    API.newQueryView region 

  App.commands.setHandler "new:queries:query", (region) ->
    API.newQueryView region

  App.addInitializer ->
    new QueriesApp.Router
      controller: API