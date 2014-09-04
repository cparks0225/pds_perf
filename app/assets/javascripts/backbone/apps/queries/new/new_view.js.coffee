@PdsPerf.module "QueriesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Query extends App.Views.ItemView
    template: "queries/new/new_query"
    class: "panel-body"

    triggers:
      "click #cancel-new-query" : "cancel:new:query:button:clicked"
