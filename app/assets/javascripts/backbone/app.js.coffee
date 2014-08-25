@PdsPerf = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on "before:start", (options) ->
    console.log "initialize:before"
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
    console.log "start history"
    if Backbone.history
      Backbone.history.start()

  App
  