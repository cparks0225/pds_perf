@PdsPerf.module "TestsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Controller extends App.Controllers.Base

    initialize: ->
      @queries = App.request "queries:entities"
      @tests = App.request "tests:entities"

      App.execute "when:fetched", [@queries, @tests], =>
        for t in @tests.models
          extended_queries = []
          for q in t.get("queries")
            tq = @queries.get(q.id)
            extended_queries.push _.extend(q, tq.toJSON())
          t.set("queries", extended_queries)

        console.log @tests
        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showPanel()
          @showTests()

        @show @layout

    showPanel: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:tests:button:clicked", =>
        console.log "new test"
        @newRegion()

      @layout.panelRegion.show panelView

    showTests: ->
      testsView = @getTestsView()

      @listenTo testsView, "childview:tests:delete:clicked", (child) ->
        console.log "delete clicked"
        console.log child.model
        child.model.destroy()

      @layout.testsRegion.show testsView

    getLayoutView: ->
      new List.LayoutView

    getPanelView: ->
      new List.Panel

    getTestsView: ->
      console.log "show tests"
      console.log @tests
      new List.Tests
        collection: @tests

    newRegion: ->
      App.execute "new:tests:test", @layout.newRegion