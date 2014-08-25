@PdsPerf.module "ResultsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  List.Controller =
    
    listResults: ->
      resultsView = @getResultsView()
      
      App.mainRegion.show resultsView
    
    getResultsView: ->
      new List.Results