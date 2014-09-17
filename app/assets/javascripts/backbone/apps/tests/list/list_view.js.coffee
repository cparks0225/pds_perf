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

  class List.Empty extends App.Views.ItemView
    template: "tests/list/_empty"
    tagName: "li"
    className: "list-group-item text-center list-group-item-warning"

  class List.Tests extends App.Views.CompositeView
    template: "tests/list/tests_list"
    childView: List.Test
    emptyView: List.Empty
    childViewContainer: "div"
    className: "panel-group"

    # onRender: ->
    #   current_system = App.request "get:system:selected"
    #   App.execute "when:fetched", [current_system], =>
    #     if not current_system.has("name")
    #       $(@el).find("li").addClass "list-group-item-danger"
    #       $(@el).find("h4").html "No System Selected"