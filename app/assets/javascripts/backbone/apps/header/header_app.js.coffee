@PdsPerf.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listHeader: ->
      new HeaderApp.List.Controller()

  App.vent.on "page:selected", (page) ->
    App.navigate page.get("slug"), trigger:true

  App.vent.on "systems:created", ->
    API.listHeader()

  App.vent.on "environments:created", ->
    API.listHeader()


  App.vent.on "model:set:active", (m) =>
    console.log "header draw"
    API.listHeader()
     
  App.addInitializer ->
    API.listHeader()
