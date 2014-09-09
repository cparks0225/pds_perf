@PdsPerf.module "SuitesApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Controller extends App.Controllers.Base

    initialize: ->
      @tests = App.request "tests:entities"
      @suites = App.request "suites:entities"

      App.execute "when:fetched", [@tests, @suites], =>
        console.log "Suites collections fetched"
        console.log @tests
        console.log @suites

    #     for t in @tests.models
    #       extended_queries = []
    #       for q in t.get("queries")
    #         tq = @queries.get(q.id)
    #         extended_queries.push _.extend(q, tq.toJSON())
    #       t.set("queries", extended_queries)

    #     console.log @tests
        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showPanel()
          @showSuites()

        @show @layout

    showPanel: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:suites:button:clicked", =>
        console.log "new suite"
        @newRegion()

      @layout.panelRegion.show panelView

    showSuites: ->
      suitesView = @getSuitesView()

      @listenTo suitesView, "childview:suites:delete:clicked", (child) ->
        console.log "delete clicked"
        console.log child.model
        child.model.destroy()

      @layout.suitesRegion.show suitesView

    getLayoutView: ->
      new List.LayoutView

    getPanelView: ->
      new List.Panel

    getSuitesView: ->
      console.log "getSuitesView"
      console.log @suites
      new List.Suites
        collection: @suites

    newRegion: ->
      App.execute "new:suites:suite", @layout.newRegion
