@PdsPerf.module "SystemsApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.System extends App.Views.ItemView
    template: "systems/new/_new_system"

    triggers:
      "click #new-system" : "new:system:button:clicked"
      "click #cancel-new-system" : "cancel:new:system:button:clicked"