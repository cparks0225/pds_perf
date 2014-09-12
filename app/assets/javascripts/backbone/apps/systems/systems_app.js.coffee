@PdsPerf.module "SystemsApp", (SystemsApp, App, Backbone, Marionette, $, _) ->

  class SystemsApp.Router extends Marionette.AppRouter
    appRoutes:
      "systems" : "listSystems"

  API =
    listSystems: ->
      new SystemsApp.List.Controller

    newSystemsView: (region) ->
      new SystemsApp.New.Controller
        region: region

    newHeaderSystemsView: (region, systems) ->
      console.log "new header systems view"
      v = new SystemsApp.List.SystemsForHeader
        collection: systems

      console.log v
      region.show(v)

  App.commands.setHandler "new:systems:view", (region) ->
    API.newSystemsView region

  App.commands.setHandler "get:header:systems", (region, systems) ->
    API.newHeaderSystemsView region, systems

  App.vent.on "systems:created", ->
    API.listSystems()

  App.addInitializer ->
    new SystemsApp.Router
      controller: API
