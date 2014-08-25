@PdsPerf.module "TestsApp", (TestsApp, App, Backbone, Marionette, $, _) ->

  class TestsApp.Router extends Marionette.AppRouter
    appRoutes:
      "tests" : "listTests"

  API =
    listTests: ->
      TestsApp.List.Controller.listTests()

  App.addInitializer ->
    new TestsApp.Router
      controller: API
