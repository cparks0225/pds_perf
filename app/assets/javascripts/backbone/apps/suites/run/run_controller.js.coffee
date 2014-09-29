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

    pad: (a, b) ->
      (1e15 + a + "").slice -b

    showSuiteView: ->
      suite_view = @getSuiteView()

      @listenTo suite_view, "suite:download:button:clicked", =>
        utcSeconds = (new Date).getTime() / 1000
        d = new Date(0)
        d.setUTCSeconds utcSeconds
        d_str += @pad(d.getFullYear(), 4)
        d_str = @pad(d.getMonth(), 2)
        d_str += @pad(d.getDate(), 2)
        d_str += "T"
        d_str += @pad(d.getHours(), 2)
        d_str += @pad(d.getMinutes(), 2)
        d_str += @pad(d.getSeconds(), 2)
        file_name = @suite.get("name") + "_" + d_str + ".csv"

        headers = []
        _.each $('table:first').find('th'), (th) ->
          headers.push(th.innerHTML)
          return

        rows = []
        rows.push( headers )
        _.each $('table').find('tr'), (tr) ->
          row = []
          _.each $(tr).find('td'), (td) ->
            row.push(td.innerHTML)
            return

          if row.length > 0
            rows.push(row)
            return

        # Rows object is reader with headers and every query data
        console.log rows
        csvContent = "data:text/csv;charset=utf-8,"
        rows.forEach (infoArray, index) ->
          dataString = infoArray.join(",")
          csvContent += (if index < rows.length then dataString + "\n" else dataString)
          return


        encodedUri = encodeURI(csvContent)
        link = document.createElement("a")
        link.setAttribute "href", encodedUri
        link.setAttribute "download", file_name
        link.click()


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

      for test in @suite.get("tests")
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
                resultStatus: "pending"

              suite_test_queries_collection.add new_query

          new_test.set
            queries: suite_test_queries_collection

          new_test.runTest()

          suite_tests_collection.add new_test

        @suite.set("tests", suite_tests_collection)
