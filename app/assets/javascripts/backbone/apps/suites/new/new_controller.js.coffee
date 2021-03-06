@PdsPerf.module "SuitesApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base

    initialize: =>
      @tests = App.request "tests:entities"
      @queries = App.request "queries:entities"
      @server_suites = App.request "suites:entities"
      @new_suite = App.request "new:suites:entity"
      @suite_tests = App.request "new:tests:entities"

      App.execute "when:fetched", [@queries, @tests, @server_suites], =>
        @layout = @getSuiteBuilder()

        for t in @tests.models
          extended_queries = []
          for q in t.get("queries")
            tq = @queries.get(q.id)
            extended_queries.push _.extend(q, tq.toJSON())
          t.set("queries", extended_queries)

        @listenTo @layout, "show", =>
          @showNewSuite()
          @showTests @tests

        @listenTo @layout, "cancel:new:suite:button:clicked", =>
          @region.reset()
          @destroy()

        @show @layout

    showNewSuite: =>
      v = @getNewTestSuiteView()

      @listenTo v, "childview:remove:suite:test", (e) =>
        @suite_tests.remove e.model
        @tests.add e.model

      @listenTo v, "suite:create:button:clicked", (e) =>
        data = Backbone.Syphon.serialize v
        tests_list = []
        for t in e.collection.models
          iter_key = "iterations-" + t.get("id")
          int_key = "interval-" + t.get("id")
          t.set "iterations", data[iter_key]
          t.set "interval", data[int_key]
          tests_list.push _.omit(t.toJSON(), 'name')

        if tests_list.length <= 0
          alert("Must add some Tests first")
        else if data.name == ""
          alert("Please supply a Suite name")
        else
          new_suite_data =
            name: data.name.replace(/\s/g, "_")
            tests: tests_list

          @server_suites.create new_suite_data

          App.navigate "/suites", trigger:true

      @layout.suiteRegion.show v

    showTests: (tests) =>
      v = App.request "suites:tests:view", tests

      @listenTo v, "childview:suites:tests:add:clicked", (e) =>
        @suite_tests.add e.model
        @tests.remove e.model

      @layout.testsRegion.show v

    getSuiteBuilder: ->
      new New.SuiteBuilder

    getNewTestSuiteView: =>
      new New.Suite
        collection: @suite_tests
