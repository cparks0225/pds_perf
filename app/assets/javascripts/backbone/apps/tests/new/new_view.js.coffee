@PdsPerf.module "TestsApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.TestBuilder extends App.Views.LayoutView
    template: "tests/new/test_builder"
    class: "panel-body"

    regions:
      testRegion: "#test-region"
      queriesRegion: "#queries-region"

    triggers:
      "click #cancel-new-test" : "cancel:new:test:button:clicked"

  class New.TestQuery extends App.Views.ItemView
    template: "tests/new/_test_query"
    class: "form-group"

    triggers:
      "click button" : "remove:test:query"

  class New.Test extends App.Views.CompositeView
    template: "tests/new/new_test"
    childView: New.TestQuery
    childViewContainer: "#added-queries"


  # class List.QueryForTests extends App.Views.ItemView
  #   template: "queries/list/_query_for_tests"
  #   tagName: "li"
  #   className: "list-group-item"

  #   onRender: ->
  #     display_class = "restful-operation-" + @model.get("method").toLowerCase()
  #     $(@.$el).addClass( display_class )

  #   triggers:
  #     "click button" : "tests:queries:add:clicked"

  # class List.QueriesForTests extends App.Views.CompositeView
  #   template: "queries/list/_queries"
  #   childView: List.QueryForTests
  #   emptyView: List.Emtpy
  #   childViewContainer: "ul"