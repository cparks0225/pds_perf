@PdsPerf.module "TestsApp", (TestsApp, App, Backbone, Marionette, $, _) ->

  class TestsApp.Router extends Marionette.AppRouter
    appRoutes:
      "tests" : "adjustUrl"
      "tests/" : "adjustUrl"
      "tests/:system" : "listTests"

  API =
    adjustUrl: ->
      current_system = App.request "get:system:selected"
      App.execute "when:fetched", [current_system], ->
        if current_system.has("name")
          App.navigate "/tests" + current_system.get("slug"), trigger:true
        
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
