@PdsPerf.module "TestsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Controller extends App.Controllers.Base

    initialize: ->
      @queries = App.request "queries:entities"
      @tests = App.request "tests:entities"
      environments = App.request "environments:entities"

      App.execute "when:fetched", [@queries, @tests, environments], =>

        active = false
        for e in environments.models
          if e.get("active")
            active = true
            
        for t in @tests.models
          extended_queries = []
          for q in t.get("queries")
            tq = @queries.get(q.id)
            extended_queries.push _.extend(q, tq.toJSON())
          t.set("queries", extended_queries)

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showPanel()
          if active
            @showTests()
          else
            @showNoEnv()

        @show @layout

    showNoEnv: ->
      App.execute "new:no:environment:selected:view", @layout.testsRegion

    showPanel: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:tests:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panelView

    showTests: ->
      testsView = @getTestsView()

      @listenTo testsView, "childview:tests:delete:clicked", (child) ->
        child.model.destroy()

      @layout.testsRegion.show testsView

    getLayoutView: ->
      new List.LayoutView

    getPanelView: ->
      new List.Panel

    getTestsView: ->
      new List.Tests
        collection: @tests

    newRegion: ->
      App.execute "new:tests:test", @layout.newRegion
      