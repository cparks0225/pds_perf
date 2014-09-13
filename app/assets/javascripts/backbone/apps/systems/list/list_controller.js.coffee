@PdsPerf.module "SystemsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Controller extends App.Controllers.Base

    initialize: ->
      @systems = App.request "systems:entities"

      App.execute "when:fetched", [@systems], =>
        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showPanel()
          @showSystems()

        @show @layout

    showPanel: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:systems:button:clicked", =>
        @newSystemView()

      @layout.panelRegion.show panelView

    showSystems: ->
      systems = @getSystemsView()
      @layout.systemsRegion.show systems

    newSystemView: ->
      App.execute "new:systems:view", @layout.newRegion

    getPanelView: ->
      new List.PanelView

    getLayoutView: ->
      new List.LayoutView

    getSystemsView: ->
      new List.Systems
        collection: @systems