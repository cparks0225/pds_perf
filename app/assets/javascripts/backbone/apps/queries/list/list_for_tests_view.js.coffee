@PdsPerf.module "QueriesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.QueryForTests extends App.Views.ItemView
    template: "queries/list/_query_for_tests"
    tagName: "tr"

    onRender: ->
      display_class = "restful-operation-" + @model.get("method").toLowerCase()
      $(@.$el).addClass( display_class )

    triggers:
      "click button" : "tests:queries:add:clicked"

  class List.QueriesForTests extends App.Views.CompositeView
    template: "queries/list/_queries_for_tests"
    childView: List.QueryForTests
    emptyView: List.Emtpy
    childViewContainer: "tbody"
