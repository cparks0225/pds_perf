@PdsPerf.module "SuitesApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base

    initialize: =>
      tests = App.request "tests:entities"
      @new_suite = App.request "new:suites:entity"
      @suite_tests = App.request "new:tests:entities"

      App.execute "when:fetched", [tests], =>
        @layout = @getSuiteBuilder()

        @listenTo @layout, "show", =>
          # @showNewTest()
          @showTests tests

        @listenTo @layout, "cancel:new:suite:button:clicked", =>
          @region.reset()
          @destroy()

        @show @layout

    # showNewTest: =>
    #   v = @getNewTestView()

    #   @listenTo v, "childview:remove:test:query", (e) =>
    #     @test_queries.remove e.model

    #   @listenTo v, "test:create:button:clicked", (e) =>
    #     data = Backbone.Syphon.serialize v
    #     queries_list = []
    #     for q in e.collection.models
    #       iter_key = "iterations-" + q.get("id")
    #       int_key = "interval-" + q.get("id")
    #       q.set "iterations", data[iter_key]
    #       q.set "interval", data[int_key]
    #       queries_list.push _.omit(q.toJSON(), 'data', 'method', 'url')

    #     new_test_data =
    #       name: data.name.replace(/\s/g, "_")
    #       queries: queries_list

    #     console.log "Saving new test"
    #     console.log new_test_data
    #     @new_test.save new_test_data

    #   @layout.testRegion.show v

    showTests: (tests) =>
      v = App.request "suites:tests:view", tests

      # @listenTo v, "childview:suites:tests:add:clicked", (e) =>
      #   @suite_tests.add e.model

      @layout.testsRegion.show v

    getSuiteBuilder: ->
      new New.SuiteBuilder

    # getNewTestView: =>
    #   new New.Test
    #     collection: @test_queries