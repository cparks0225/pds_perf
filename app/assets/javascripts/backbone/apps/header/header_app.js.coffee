@PdsPerf.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listHeader: ->
      new HeaderApp.List.Controller()

  App.addInitializer ->
    API.listHeader()
