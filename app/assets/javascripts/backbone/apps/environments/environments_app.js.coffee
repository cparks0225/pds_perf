@PdsPerf.module "EnvironmentsApp", (EnvironmentsApp, App, Backbone, Marionette, $, _) ->

  class EnvironmentsApp.Router extends Marionette.AppRouter
    appRoutes:
      "environments" : "listEnvironments"

  API =
    listEnvironments: ->
      EnvironmentsApp.List.Controller.listEnvironments()

  App.addInitializer ->
    new EnvironmentsApp.Router
      controller: API
