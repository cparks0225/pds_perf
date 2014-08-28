@PdsPerf.module "EnvironmentsApp", (EnvironmentsApp, App, Backbone, Marionette, $, _) ->

  class EnvironmentsApp.Router extends Marionette.AppRouter
    appRoutes:
      "environments" : "listEnvironments"

  API =
    listEnvironments: ->
      EnvironmentsApp.List.Controller.listEnvironments()

    newEnvironment: ->
      EnvironmentsApp.New.Controller.newEnvironment()

    setSelectedEnvironment: (environment) ->
      console.log "setSelectedEnvironment"
      console.log environment
      App.request "set:selected:environment", environment
      #App.request "get:selected:environment"

  App.reqres.setHandler "new:environments:environment:view", ->
    API.newEnvironment()

  App.vent.on "environments:environment:clicked", (environment) ->
    API.setSelectedEnvironment environment

  App.addInitializer ->
    new EnvironmentsApp.Router
      controller: API
