@PdsPerf.module "TestsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  List.Controller =
    
    listTests: ->
      testsView = @getTestsView()
      
      App.mainRegion.show testsView
    
    getTestsView: ->
      new List.Tests