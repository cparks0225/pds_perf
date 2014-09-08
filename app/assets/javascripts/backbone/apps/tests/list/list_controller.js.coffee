@PdsPerf.module "TestsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Controller extends App.Controllers.Base

    initialize: ->
      queries = App.request "queries:entities"

      App.execute "when:fetched", [queries], =>

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showPanel()
        #   @showQueries queries

        @show @layout

    showPanel: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:tests:button:clicked", =>
        console.log "new test"
        @newRegion()

      @layout.panelRegion.show panelView

    getPanelView: ->
      new List.Panel

    getLayoutView: ->
      new List.LayoutView

    newRegion: ->
      App.execute "new:tests:test", @layout.newRegion