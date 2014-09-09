@PdsPerf.module "SuitesApp.Run", (Run, App, Backbone, Marionette, $, _) ->
  
  class Run.Controller extends App.Controllers.Base

    initialize: (suite) =>

      @suite = App.request "suites:entity", suite
      @tests = App.request "tests:entities"
      @queries = App.request "queries:entities"
      App.execute "when:fetched", [@suite, @tests, @queries], =>

        @fetchSuiteTestsData()

        @layout = @getRunLayout()

        @listenTo @layout, "show", =>
          @showSuiteView()
          @showTestsView()

        @show @layout

    getRunLayout: =>
      new Run.LayoutView

    showSuiteView: ->
      suite_view = @getSuiteView()
      @layout.suiteRegion.show suite_view

    showTestsView: ->
      tests_view = @getTestsView()
      @layout.testsRegion.show tests_view

    getSuiteView: ->
      new Run.Suite
        model: @suite

    getTestsView: ->
      new Run.Tests
        collection: @suite.get("tests")

    fetchSuiteTestsData: ->
      suite_tests_collection = App.request "new:tests:entities"

      console.log "______"
      for test in @suite.get("tests")
        console.log test
        new_test_data = @tests.get test.id
        for iter in [0...test.iterations]
          new_test = App.request "new:tests:entity"
          new_test.set _.omit(new_test_data.toJSON(), "id")
          new_test.set
            iteration: iter + 1
            interval: parseInt test.interval

          suite_test_queries_collection = App.request "new:queries:entities"
          for query in new_test.get "queries"
            new_query_data = @queries.get query.id
            for qiter in [0...query.iterations]
              new_query = App.request "new:queries:entity"
              new_query.set _.omit(new_query_data.toJSON(), "id")
              new_query.set
                iteration: qiter + 1
                interval: parseInt query.interval

              suite_test_queries_collection.add new_query

          new_test.set
            queries: suite_test_queries_collection

          suite_tests_collection.add new_test

      console.log "______"

      @suite.set("tests", suite_tests_collection)
      console.log @suite
