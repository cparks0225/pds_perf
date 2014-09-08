@PdsPerf.module "SuitesApp", (SuitesApp, App, Backbone, Marionette, $, _) ->

  class SuitesApp.Router extends Marionette.AppRouter
    appRoutes:
      "suites" : "listSuites"

  API =
    listSuites: ->
      new SuitesApp.List.Controller

    newSuiteView: (region) ->
      new SuitesApp.New.Controller
        region: region

  App.commands.setHandler "new:suites:suite", (region) ->
    API.newSuiteView region

  App.addInitializer ->
    new SuitesApp.Router
      controller: API
