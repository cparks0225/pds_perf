@PdsPerf.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listHeader: ->
      new HeaderApp.List.Controller()

    setSelectedPage: (page) ->
      localStorage.setItem("Page", page.get("slug"))

  App.vent.on "page:selected", (page) ->
    API.setSelectedPage page
    App.execute "navigate", page.get("slug")

  App.addInitializer ->
    API.listHeader()
