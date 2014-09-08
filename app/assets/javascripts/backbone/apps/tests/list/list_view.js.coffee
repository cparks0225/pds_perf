@PdsPerf.module "TestsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.LayoutView extends App.Views.LayoutView
    template: "tests/list/list_layoutview"
    id: "tests-list"

    regions:
      panelRegion: "#panel-region"
      newRegion: "#new-region"
      testsRegion: "#tests-region"

  class List.Panel extends App.Views.ItemView
    template: "tests/list/_panel"

    triggers:
      "click #new-test" : "new:tests:button:clicked"

  class List.Test extends App.Views.ItemView
    template: "tests/list/_test"

    triggers:
      "click button" : "tests:delete:clicked"

  class List.Tests extends App.Views.CompositeView
    template: "tests/list/tests_list"
    childView: List.Test
    childViewContainer: "div"
    className: "panel-group"

    # triggers:
      # "submit" : "test:create:button:clicked"