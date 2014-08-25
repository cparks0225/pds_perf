@PdsPerf = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.rootRoute = Routes.environments_path()

  App.on "before:start", (options) ->
    @currentQuery = App.request "set:current:query", options.currentQuery

  App.reqres.setHandler "get:current:query", ->
    App.currentQuery

  App.addRegions
    headerRegion: "#header-region"
    mainRegion: "#main-region"
    footerRegion: "#footer-region"

  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()

  App.on "start", (options) ->
    if Backbone.history
      Backbone.history.start()
      console.log "navigate to root route"
      @navigate(@rootRoute, trigger: true) if @getCurrentRoute() is null

  App
  