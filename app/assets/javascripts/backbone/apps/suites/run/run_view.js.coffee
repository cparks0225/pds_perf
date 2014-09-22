@PdsPerf.module "SuitesApp.Run", (Run, App, Backbone, Marionette, $, _) ->
  
  class Run.LayoutView extends App.Views.LayoutView
    template: "suites/run/run_layoutview"
    id: "suite-run"

    regions:
      suiteRegion: "#suite-region"
      testsRegion: "#tests-region"

  class Run.Suite extends App.Views.ItemView
    template: "suites/run/suite"

    triggers:
      "click button" : "suite:download:button:clicked"

  class Run.Query extends App.Views.ItemView
    template: "suites/run/query"
    tagName: "tr"

    modelEvents:
      "change": ->
        $(@el).removeClass()
        switch @model.get("resultStatus")
          when "pending" then $(@el).addClass("")
          when "running" then $(@el).addClass("active")
          when "success" then $(@el).addClass("success")
          when "error" then $(@el).addClass("danger")
        @render()

  class Run.Test extends App.Views.CompositeView
    template: "suites/run/test"
    className: "panel panel-info"

    initialize: ->
      @collection = @model.get("queries")

    childView: Run.Query
    childViewContainer: "table"

  class Run.Tests extends App.Views.CompositeView
    template: "suites/run/tests"
    childView: Run.Test
    childViewContainer: "div"
