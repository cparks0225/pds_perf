@PdsPerf.module "QueriesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      queries = App.request "queries:entities"

      App.execute "when:fetched", [queries], =>

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showPanel()
          @showQueries queries

        @show @layout

    showPanel: ->
      panelView = @getPanelView()

      console.log '1'
      @listenTo panelView, "new:queries:button:clicked", =>
        console.log "1.5"
        @newRegion()

      console.log '2'
      @layout.panelRegion.show panelView

    showQueries: (queries) ->
      queriesView = @getQueriesView queries

      queriesView.on "childview:queries:query:clicked", (child, environment) ->
        # Toggle the CSS to display the currently selected environment
        $(child.el).closest(".list-group").children(".list-group-item-info").removeClass("list-group-item-info");
        $(child.el).addClass("list-group-item-info")

      queriesView.on "childview:queries:delete:clicked", (child) ->
        App.vent.trigger "queries:delete:clicked", child.model

      @layout.queriesRegion.show queriesView

    getPanelView: ->
      new List.Panel

    getQueriesView: (queries) ->
      new List.Queries
        collection: queries

    getLayoutView: ->
      new List.LayoutView

    newRegion: ->
      App.execute "new:queries:query", @layout.newRegion
