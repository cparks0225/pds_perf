@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Environments extends App.Views.ItemView
    template: "environments/list/templates/list_environments"