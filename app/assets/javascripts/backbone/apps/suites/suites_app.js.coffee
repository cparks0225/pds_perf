@PdsPerf.module "SuitesApp", (SuitesApp, App, Backbone, Marionette, $, _) ->

  class SuitesApp.Router extends Marionette.AppRouter
    appRoutes:
      "suites" : "listSuites"
      "suites/" : "listSuites"

  API =
    listSuites: ->
      new SuitesApp.List.Controller

    newRunView: (suite) ->
      new SuitesApp.Run.Controller suite

    newSuiteView: (region) ->
      new SuitesApp.New.Controller
        region: region

  App.commands.setHandler "new:suites:suite", (region) ->
    API.newSuiteView region

  App.vent.on "model:set:active", (system) ->
    if not ((Routes.suites_path().indexOf(App.getCurrentRoute())) == -1)
      API.listSuites()

  App.addInitializer ->
    new SuitesApp.Router
      controller: API
