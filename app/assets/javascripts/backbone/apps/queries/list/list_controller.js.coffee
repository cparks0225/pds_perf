@PdsPerf.module "QueriesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      queries = App.request "queries:entities"
      environments = App.request "environments:entities"

      App.execute "when:fetched", [queries, environments], =>

        active = false
        for e in environments.models
          if e.get("active")
            active = true

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showPanel()
          if active
            @showQueries queries
          else
            @showNoEnv()

        @show @layout

    showPanel: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:queries:button:clicked", =>
        @newRegion()

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

    showNoEnv: ->
      App.execute "new:no:environment:selected:view", @layout.queriesRegion

    getPanelView: ->
      new List.Panel

    getQueriesView: (queries) ->
      new List.Queries
        collection: queries

    getLayoutView: ->
      new List.LayoutView

    newRegion: ->
      App.execute "new:queries:query", @layout.newRegion
