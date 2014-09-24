@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Controller extends App.Controllers.Base
    
    initialize: ->
      @environments = App.request "environments:entities"

      App.execute "when:fetched", [@environments], =>
        @environments.pop()
        @environments.pop()
        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showPanel()
          @environmentsRegion()

        @show @layout
    
    showPanel: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:environments:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panelView

    environmentsRegion:  ->
      environmentsView = @getEnvironmentsView @environments

      environmentsView.on "childview:environments:delete:clicked", (child) ->
        App.vent.trigger "environments:delete:clicked", child.model

      @layout.environmentsRegion.show environmentsView

    newEnvironmentRegion: ->
      newEnvironmentView = App.execute "new:environments:environment:view", @layout.newEnvironmentRegion

    getPanelView: ->
      new List.Panel

    getNoEnvironmentView: ->
      new List.NoEnvironment

    getEnvironmentsView: ->
      new List.Environments
        collection: @environments

    getLayoutView: ->
      new List.LayoutView

    newRegion: ->
      App.execute "new:environments:environment", @layout.newEnvironmentRegion
