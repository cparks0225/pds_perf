@PdsPerf.module "SuitesApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  List.Controller =
    
    listSuites: ->
      suitesView = @getSuitesView()
      
      App.mainRegion.show suitesView
    
    getSuitesView: ->
      new List.Suites