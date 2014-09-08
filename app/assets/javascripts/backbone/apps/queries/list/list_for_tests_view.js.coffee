@PdsPerf.module "QueriesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.QueryForTests extends App.Views.ItemView
    template: "queries/list/_query_for_tests"
    tagName: "li"
    className: "list-group-item"

    onRender: ->
      display_class = "restful-operation-" + @model.get("method").toLowerCase()
      $(@.$el).addClass( display_class )

    events:
      "click" : -> @trigger "queries:query:clicked", @model

    triggers:
      "click button" : "tests:queries:add:clicked"

  class List.QueriesForTests extends App.Views.CompositeView
    template: "queries/list/_queries"
    childView: List.QueryForTests
    emptyView: List.Emtpy
    childViewContainer: "ul"
