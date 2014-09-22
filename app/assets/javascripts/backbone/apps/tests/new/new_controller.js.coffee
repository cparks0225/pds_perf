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

      @listenTo v, "test:create:button:clicked", (e) =>
        data = Backbone.Syphon.serialize v
        queries_list = []
        for q in e.collection.models
          iter_key = "iterations-" + q.get("id")
          int_key = "interval-" + q.get("id")
          q.set "iterations", data[iter_key]
          q.set "interval", data[int_key]
          queries_list.push _.omit(q.toJSON(), 'data', 'method', 'url', 'can_delete')

        if queries_list.length <= 0
          alert("Must add some Queries first")
        else if data.name == ""
          alert("Please supply a test name")
        else
          new_test_data =
            name: data.name.replace(/\s/g, "_")
            queries: queries_list

          @new_test.save new_test_data

          App.navigate "/tests", trigger:true

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
