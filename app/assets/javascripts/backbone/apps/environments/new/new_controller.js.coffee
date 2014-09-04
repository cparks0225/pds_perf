@PdsPerf.module "EnvironmentsApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base
    
    initialize: ->
      environment = App.request "new:environments:entity"

      @listenTo environment, "created", ->
        App.vent.trigger "environments:created", environment 

      newView = @getNewEnvironmentView environment

      @listenTo newView, "new:environment:button:clicked", ->
        console.log "add clicked"

        data = Backbone.Syphon.serialize newView
        console.log data
        console.log newView.model
        console.log newView.collection
        newView.model.save data,
          collection: newView.collection

      @show newView

    getNewEnvironmentView: (env) ->
      new New.Environment
        model: env
