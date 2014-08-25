@PdsPerf.module "ResultsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Results extends App.Views.ItemView
    template: "results/list/list_results"