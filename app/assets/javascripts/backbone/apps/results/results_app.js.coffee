@PdsPerf.module "ResultsApp", (ResultsApp, App, Backbone, Marionette, $, _) ->

  class ResultsApp.Router extends Marionette.AppRouter
    appRoutes:
      "results" : "adjustUrl"
      "results/" : "adjustUrl"
      "results" : "listResults"

  API =
    adjustUrl: ->
      current_system = App.request "get:system:selected"
      App.execute "when:fetched", [current_system], ->
        App.navigate "/results/" + current_system.get("slug"), trigger:true
        
    listResults: ->
      ResultsApp.List.Controller.listResults()

  App.addInitializer ->
    new ResultsApp.Router
      controller: API
