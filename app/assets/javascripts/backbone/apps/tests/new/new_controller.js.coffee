@PdsPerf.module "TestsApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base

    initialize: =>
      queries = App.request "queries:entities"
      @new_test = App.request "new:tests:entity"
      @test_queries = App.request "new:queries:entities"

      App.execute "when:fetched", [queries], =>
        @layout = @getTestBuilder()

        @listenTo @layout, "show", =>
          @showNewTest()
          @showQueries queries

        @listenTo @layout, "cancel:new:test:button:clicked", =>
          @region.reset()
          @destroy()

        @show @layout

    showNewTest: =>
      v = @getNewTestView()

      @listenTo v, "childview:remove:test:query", (e) =>
        @test_queries.remove e.model

      @layout.testRegion.show v

    showQueries: (queries) =>
      v = App.request "tests:queries:view", queries

      @listenTo v, "childview:tests:queries:add:clicked", (e) =>
        @test_queries.add e.model

      @layout.queriesRegion.show v

    getTestBuilder: ->
      new New.TestBuilder

    getNewTestView: =>
      new New.Test
        collection: @test_queries