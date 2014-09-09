@PdsPerf.module "SuitesApp.Run", (Run, App, Backbone, Marionette, $, _) ->
  
  class Run.LayoutView extends App.Views.LayoutView
    template: "suites/run/run_layoutview"
    id: "suite-run"

    regions:
      suiteRegion: "#suite-region"
      testsRegion: "#tests-region"

  class Run.Suite extends App.Views.ItemView
    template: "suites/run/suite"

  class Run.Query extends App.Views.ItemView
    template: "suites/run/query"

  class Run.Test extends App.Views.CompositeView
    template: "suites/run/test"
    className: "panel panel-info"

    initialize: ->
      @collection = @model.get("queries")

    childView: Run.Query

  class Run.Tests extends App.Views.CompositeView
    template: "suites/run/tests"
    childView: Run.Test
    childViewContainer: "div"
