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
    className: "list-group-item" # restful-operation-" + @model.get("method")

    onRender: ->
      console.log "Query Rendered"
      display_class = "restful-operation-" + @model.get("method").toLowerCase()
      console.log $(@.$el).addClass( display_class )

    events:
      "click" : -> @trigger "queries:query:clicked", @model

    triggers:
      "click button" : "queries:delete:clicked"

  class List.Empty extends App.Views.ItemView
    template: "queries/list/_empty"
    tagName: "li"
    className: "list-group-item"

  class List.Queries extends App.Views.CompositeView
    template: "queries/list/_queries"
    childView: List.Query
    emptyView: List.Emtpy
    childViewContainer: "ul"