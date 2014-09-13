@PdsPerf.module "EnvironmentsApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base
    
    initialize: ->
      environment = App.request "new:environments:entity"

      @listenTo environment, "created", ->
        App.vent.trigger "environments:created", environment 

      newView = @getNewEnvironmentView environment

      @listenTo newView, "new:environment:button:clicked", ->
        data = Backbone.Syphon.serialize newView
        newView.model.save data,
          collection: newView.collection

      @listenTo newView, "cancel:new:environment:button:clicked", =>
        @region.reset()
        @destroy() 

      @show newView

    getNewEnvironmentView: (env) ->
      new New.Environment
        model: env
