@PdsPerf.module "QueriesApp", (QueriesApp, App, Backbone, Marionette, $, _) ->

  class QueriesApp.Router extends Marionette.AppRouter
    appRoutes:
      "queries" : "listQueries"

  API =
    listQueries: ->
      new QueriesApp.List.Controller

    # listRestfuls: (api) ->
      # console.log "list restfuls for", api

    deleteQuery: (query) ->
      query.destroy()

    newQueryView: (region) ->
      new QueriesApp.New.Controller
        region: region
        
  App.vent.on "queries:delete:clicked", (query) ->
    API.deleteQuery query

  # App.vent.on "queries:api:clicked", (query) ->
    # API.listRestfuls query

  App.commands.setHandler "new:queries:query:view", (region) ->
    API.newQueryView region 

  App.commands.setHandler "new:queries:query", (region) ->
    API.newQueryView region

  App.addInitializer ->
    new QueriesApp.Router
      controller: API