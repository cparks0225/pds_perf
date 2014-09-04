@PdsPerf.module "QueriesApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base
    
    initialize: ->
      query = App.request "new:queries:entity"

      @listenTo query, "created", ->
        App.vent.trigger "queries:created", query 

      newView = @getNewQueryView query

      @listenTo newView, "cancel:new:query:button:clicked", =>
        @region.reset()
        @destroy()

      @show newView

    getNewQueryView: (env) ->
      new New.Query
        model: env
