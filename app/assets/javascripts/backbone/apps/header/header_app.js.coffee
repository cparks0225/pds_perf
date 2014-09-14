@PdsPerf.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listHeader: ->
      new HeaderApp.List.Controller()

    setSelectedPage: (page) ->
      localStorage.setItem("Page", page.get("slug"))

  App.vent.on "page:selected", (page) ->
    API.setSelectedPage page
    App.navigate page.get("slug"), trigger:true

  App.addInitializer ->
    API.listHeader()
