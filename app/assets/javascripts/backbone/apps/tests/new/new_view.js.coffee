@PdsPerf.module "TestsApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.TestBuilder extends App.Views.LayoutView
    template: "tests/new/test_builder"
    class: "panel-body"

    regions:
      testsRegion: "#tests-region"
      queriesRegion: "#queries-region"

    triggers:
      "click #cancel-new-test" : "cancel:new:test:button:clicked"