@PdsPerf.module "QueriesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.LayoutView extends App.Views.LayoutView
    template: "queries/list/list_layoutview"
    id: "queries-list"

    regions:
      panelRegion: "#panel-region"
      newRegion: "#new-region"
      queriesRegion: "#queries-region"

  class List.Panel extends App.Views.ItemView
    template: "queries/list/_panel"

    triggers:
      "click #new-query" : "new:queries:button:clicked"

  class List.Query extends App.Views.ItemView
    template: "queries/list/_query"
    tagName: "li"
    className: "list-group-item"

    onRender: ->
      display_class = "restful-operation-" + @model.get("method").toLowerCase()
      $(@.$el).addClass( display_class )

    events:
      "click" : -> @trigger "queries:query:clicked", @model

    triggers:
      "click button" : "queries:delete:clicked"

  class List.Empty extends App.Views.ItemView
    template: "queries/list/_empty"
    tagName: "li"
    className: "list-group-item text-center list-group-item-warning"

  class List.Queries extends App.Views.CompositeView
    template: "queries/list/_queries"
    childView: List.Query
    emptyView: List.Empty
    childViewContainer: "ul"

    # onRender: ->
    #   current_system = App.request "get:system:selected"
    #   App.execute "when:fetched", [current_system], =>
    #     if not current_system.has("name")
    #       $(@el).find("li").addClass "list-group-item-danger"
    #       $(@el).find("h4").html "No System Selected"
