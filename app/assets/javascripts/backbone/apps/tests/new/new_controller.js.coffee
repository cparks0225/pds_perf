@PdsPerf.module "TestsApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base

    initialize: ->
      queries = App.request "queries:entities"

      App.execute "when:fetched", [queries], =>
        console.log "queries loaded in new Test controller"
        console.log queries

        @layout = @getTestBuilder()

        @listenTo @layout, "show", =>
          @showQueries(queries)

        @listenTo @layout, "cancel:new:test:button:clicked", =>
          @region.reset()
          @destroy()

        @show @layout

    showQueries: (queries) ->
      v = App.request "tests:queries:view", queries
      @layout.queriesRegion.show v

    #   @listenTo panelView, "new:tests:button:clicked", =>
    #     console.log "new test"
    #     @newRegion()

    #   @layout.panelRegion.show panelView

    # getPanelView: ->
      # new New.Panel

    getTestBuilder: ->
      new New.TestBuilder

    # newRegion: ->
    #   App.execute "new:tests:test", @layout.newRegion