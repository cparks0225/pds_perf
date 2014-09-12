@PdsPerf.module "TestsApp", (TestsApp, App, Backbone, Marionette, $, _) ->

  class TestsApp.Router extends Marionette.AppRouter
    appRoutes:
      "tests/:system" : "listTests"

  API =
    listTests: ->
      new TestsApp.List.Controller

    listTestsForSuites: (tests) ->
      new TestsApp.List.TestsForSuites
        collection: tests

    newTestView: (region) ->
      new TestsApp.New.Controller
        region: region

  App.commands.setHandler "new:tests:test", (region) ->
    API.newTestView region

  App.reqres.setHandler "suites:tests:view", (tests) ->
    API.listTestsForSuites tests

  App.addInitializer ->
    new TestsApp.Router
      controller: API
