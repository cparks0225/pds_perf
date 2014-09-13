@PdsPerf.module "EnvironmentsApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Environment extends App.Views.ItemView
    template: "environments/new/_new_environment"

    triggers:
      "click #new-environment" : "new:environment:button:clicked"
      "click #cancel-new-environment" : "cancel:new:environment:button:clicked"