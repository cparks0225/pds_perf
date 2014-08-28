@PdsPerf.module "EnvironmentsApp", (EnvironmentsApp, App, Backbone, Marionette, $, _) ->

  class EnvironmentsApp.Router extends Marionette.AppRouter
    appRoutes:
      "environments" : "listEnvironments"

  API =
    listEnvironments: ->
      EnvironmentsApp.List.Controller.listEnvironments()

    newEnvironmentView: ->
      EnvironmentsApp.New.Controller.newEnvironment()

  App.reqres.setHandler "new:environments:environment:view", ->
    API.newEnvironmentView()

  App.addInitializer ->
    new EnvironmentsApp.Router
      controller: API
