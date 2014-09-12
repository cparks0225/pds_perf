@PdsPerf.module "SuitesApp", (SuitesApp, App, Backbone, Marionette, $, _) ->

  class SuitesApp.Router extends Marionette.AppRouter
    appRoutes:
      "suites" : "adjustUrl"
      "suites/" : "adjustUrl"
      "suites/:system" : "listSuites"
      "suites/:system/run/:id" : "newRunView"

  API =
    adjustUrl: ->
      current_system = App.request "get:system:selected"
      App.execute "when:fetched", [current_system], ->
        if current_system.has("name")
          App.navigate "/suites" + current_system.get("slug"), trigger:true

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
