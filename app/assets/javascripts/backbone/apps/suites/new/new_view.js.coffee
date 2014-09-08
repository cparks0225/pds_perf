@PdsPerf.module "SuitesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.SuiteBuilder extends App.Views.LayoutView
    template: "suites/new/suite_builder"
    class: "panel-body"

    regions:
      suiteRegion: "#suite-region"
      testsRegion: "#tests-region"

    triggers:
      "click #cancel-new-suite" : "cancel:new:suite:button:clicked"

  # class New.TestQuery extends App.Views.ItemView
  #   template: "tests/new/_test_query"
  #   class: "form-group"

  #   triggers:
  #     "click button" : "remove:test:query"

  # class New.Test extends App.Views.CompositeView
  #   template: "tests/new/new_test"
  #   childView: New.TestQuery
  #   childViewContainer: "#added-queries"

  #   triggers:
  #     "submit" : "test:create:button:clicked"
