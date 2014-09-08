@PdsPerf.module "SuitesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.SuiteBuilder extends App.Views.LayoutView
    template: "suites/new/suite_builder"
    class: "panel-body"

    regions:
      suiteRegion: "#suite-region"
      testsRegion: "#tests-region"

    triggers:
      "click #cancel-new-suite" : "cancel:new:suite:button:clicked"

  class New.SuiteTest extends App.Views.ItemView
    template: "suites/new/_suite_test"
    class: "form-group"

    triggers:
      "click button" : "remove:suite:test"

  class New.Suite extends App.Views.CompositeView
    template: "suites/new/new_suite"
    childView: New.SuiteTest
    childViewContainer: "#added-tests"

    triggers:
      "submit" : "suite:create:button:clicked"
