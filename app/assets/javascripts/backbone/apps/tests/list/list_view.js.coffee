@PdsPerf.module "TestsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.LayoutView extends App.Views.LayoutView
    template: "tests/list/list_layoutview"
    id: "tests-list"

    regions:
      panelRegion: "#panel-region"
      newRegion: "#new-region"
      queriesRegion: "#queries-region"

  class List.Panel extends App.Views.ItemView
    template: "tests/list/_panel"

    triggers:
      "click #new-test" : "new:tests:button:clicked"