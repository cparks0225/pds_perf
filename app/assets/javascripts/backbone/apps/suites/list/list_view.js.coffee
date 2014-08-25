@PdsPerf.module "SuitesApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Suites extends App.Views.ItemView
    template: "suites/list/list_suites"