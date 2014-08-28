@PdsPerf.module "EnvironmentsApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  New.Controller =
    
    newEnvironment: ->
      newEnvironmentView = @getNewEnvironmentView()

      newEnvironmentView.on "new:environment:button:clicked", ->
        console.log "add clicked"
        
      newEnvironmentView

    getNewEnvironmentView: ->
      new New.Environment
