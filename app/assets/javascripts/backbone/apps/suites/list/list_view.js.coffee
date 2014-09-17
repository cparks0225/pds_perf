@PdsPerf.module "SuitesApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.LayoutView extends App.Views.LayoutView
    template: "suites/list/list_layoutview"
    id: "suites-list"

    regions:
      panelRegion: "#panel-region"
      newRegion: "#new-region"
      suitesRegion: "#suites-region"

  class List.Panel extends App.Views.ItemView
    template: "suites/list/_panel"

    triggers:
      "click #new-suite" : "new:suites:button:clicked"

  class List.Suite extends App.Views.ItemView
    template: "suites/list/_suite"

    triggers:
      "click .btn-danger" : "suites:delete:clicked"
      "click .btn-primary" : "suites:run:clicked"

  class List.Empty extends App.Views.ItemView
    template: "suites/list/_empty"
    tagName: "li"
    className: "list-group-item text-center list-group-item-warning"

  class List.Suites extends App.Views.CompositeView
    template: "suites/list/suites_list"
    childView: List.Suite
    emptyView: List.Empty
    childViewContainer: "div"
    className: "panel-group"

    # onRender: ->
    #   current_system = App.request "get:system:selected"
    #   App.execute "when:fetched", [current_system], =>
    #     if not current_system.has("name")
    #       $(@el).find("li").addClass "list-group-item-danger"
    #       $(@el).find("h4").html "No System Selected"