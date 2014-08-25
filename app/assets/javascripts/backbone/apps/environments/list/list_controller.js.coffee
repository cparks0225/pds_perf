@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  List.Controller =
    
    listEnvironments: ->
      App.request "environment:entities", (environments) =>
        @layout = @getLayoutView()

        @layout.on "show", =>
          @showPanel environments 
          @showEnvironments environments 

        App.mainRegion.show @layout
    
    showPanel: (environments) ->
      panelView = @getPanelView environments
      @layout.panelRegion.show panelView

    showEnvironments: (environments) ->
      environmentsView = @getEnvironmentsView environments
      @layout.environmentsRegion.show environmentsView

    getPanelView: (environments) ->
      new List.Panel
        collection: environments

    getEnvironmentsView: (environments) ->
      console.log environments
      new List.Environments
        collection: environments

    getLayoutView: ->
      new List.LayoutView