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