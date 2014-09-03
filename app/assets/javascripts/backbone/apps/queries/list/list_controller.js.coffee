@PdsPerf.module "QueryApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    listQueries: ->
      App.request "query:entities", (queries) =>

        @layout = @getLayoutView()

        @layout.on "show", =>
          @showPanel queries
          @showQueries queries

        App.mainRegion.show @layout

    showPanel: (queries) ->
      panelView = @getPanelView queries
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

    getPanelView: (queries) ->
      new List.Panel
        collection: queries

    getQueriesView: (queries) ->
      console.log queries
      new List.Queries
        collection: queries

    getLayoutView: ->
      new List.LayoutView