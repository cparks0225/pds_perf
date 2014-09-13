@PdsPerf.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listHeader: ->
      new HeaderApp.List.Controller()

    setSelectedPage: (page) ->
      localStorage.setItem("swaggernautPage", page.get("slug"))

  App.vent.on "page:selected", (page) ->
    API.setSelectedPage page
    App.execute "navigate"

  App.addInitializer ->
    API.listHeader()
