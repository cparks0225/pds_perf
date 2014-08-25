@PdsPerf.module "TestsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Tests extends App.Views.ItemView
    template: "tests/list/templates/list_tests"