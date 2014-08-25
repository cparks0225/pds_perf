@PdsPerf.module "SuitesApp", (SuitesApp, App, Backbone, Marionette, $, _) ->

  class SuitesApp.Router extends Marionette.AppRouter
    appRoutes:
      "suites" : "listSuites"

  API =
    listSuites: ->
      SuitesApp.List.Controller.listSuites()

  App.addInitializer ->
    new SuitesApp.Router
      controller: API
