@PdsPerf.module "SystemsApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base

    initialize: ->
      system = App.request "new:systems:entity"

      @listenTo system, "created", ->
        App.vent.trigger "systems:created"
        
      newView = @getNewSystemView system

      @listenTo newView, "new:system:button:clicked", ->
        data = Backbone.Syphon.serialize newView
        newView.model.save data,
          collection: newView.collection

      @listenTo newView, "cancel:new:system:button:clicked", =>
        @region.reset()
        @destroy() 

      @show newView

    getNewSystemView: (system) ->
      new New.System
        model: system
