@PdsPerf.module "TestsApp", (TestsApp, App, Backbone, Marionette, $, _) ->

  class TestsApp.Router extends Marionette.AppRouter
    appRoutes:
      "tests" : "listTests"

  API =
    listTests: ->
      new TestsApp.List.Controller

    newTestView: (region) ->
      new TestsApp.New.Controller
        region: region

  App.commands.setHandler "new:tests:test", (region) ->
    API.newTestView region

  App.addInitializer ->
    new TestsApp.Router
      controller: API
