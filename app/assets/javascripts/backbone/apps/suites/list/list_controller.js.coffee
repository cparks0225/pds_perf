@PdsPerf.module "SuitesApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Controller extends App.Controllers.Base

    initialize: ->
      @tests = App.request "tests:entities"
      @suites = App.request "suites:entities"

      App.execute "when:fetched", [@tests, @suites], =>

        for s in @suites.models
          extended_tests = []
          for t in s.get("tests")
            st = @tests.get(t.id)
            extended_tests.push _.extend(t, st.toJSON())
          s.set("tests", extended_tests)

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showPanel()
          @showSuites()

        @show @layout

    showPanel: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:suites:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panelView

    showSuites: ->
      suitesView = @getSuitesView()

      @listenTo suitesView, "childview:suites:delete:clicked", (child) ->
        child.model.destroy()

      @listenTo suitesView, "childview:suites:run:clicked", (suite) ->
        App.execute "run:suite", suite.model.get("id")

      @layout.suitesRegion.show suitesView

    getLayoutView: ->
      new List.LayoutView

    getPanelView: ->
      new List.Panel

    getSuitesView: ->
      new List.Suites
        collection: @suites

    newRegion: ->
      App.execute "new:suites:suite", @layout.newRegion
