@PdsPerf = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.rootRoute = Routes.environments_path()

  # Handle Application level requests
  App.reqres.setHandler "get:selected:environment", ->
    App.selectedEnvironment

  App.reqres.setHandler "set:selected:environment", (environment) ->
    App.selectedEnvironment = environment

  App.addRegions
    headerRegion: "#header-region"
    mainRegion: "#main-region"
    footerRegion: "#footer-region"

  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()

  App.on "start", (options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) if @getCurrentRoute() is null

  App
  