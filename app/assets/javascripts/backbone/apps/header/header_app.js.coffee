@PdsPerf.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listHeader: ->
      console.log "listHeader"
      new HeaderApp.List.Controller()

  App.addInitializer ->
    API.listHeader()
