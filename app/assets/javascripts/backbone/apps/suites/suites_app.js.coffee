@PdsPerf.module "SuitesApp", (SuitesApp, App, Backbone, Marionette, $, _) ->

  class SuitesApp.Router extends Marionette.AppRouter
    appRoutes:
      "suites/:system" : "listSuites"
      "suites/:system/run/:id" : "newRunView"

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

  App.addInitializer ->
    new SuitesApp.Router
      controller: API
