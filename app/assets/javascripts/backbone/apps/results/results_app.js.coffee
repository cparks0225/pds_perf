@PdsPerf.module "ResultsApp", (ResultsApp, App, Backbone, Marionette, $, _) ->

  class ResultsApp.Router extends Marionette.AppRouter
    appRoutes:
      "results" : "listResults"

  API =
    listResults: ->
      ResultsApp.List.Controller.listResults()

  App.addInitializer ->
    new ResultsApp.Router
      controller: API
