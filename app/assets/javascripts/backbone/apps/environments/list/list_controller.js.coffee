@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  List.Controller =
    
    listEnvironments: ->
      environmentsView = @getEnvironmentsView()
      
      App.mainRegion.show environmentsView
    
    getEnvironmentsView: ->
      new List.Environments