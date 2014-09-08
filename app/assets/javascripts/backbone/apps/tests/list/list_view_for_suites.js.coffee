@PdsPerf.module "TestsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.TestForSuites extends App.Views.ItemView
    template: "tests/list/_test_for_suites"

    triggers:
      "click button" : "tests:delete:clicked"

  class List.TestsForSuites extends App.Views.CompositeView
    template: "tests/list/tests_list"
    childView: List.TestForSuites
    childViewContainer: "div"
    className: "panel-group"
