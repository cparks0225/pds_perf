@PdsPerf = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.rootRoute = Routes.suites_path()

  App.addRegions
    headerRegion: "#header-region"
    mainRegion: "#main-region"
    footerRegion: "#footer-region"

  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()

  App.reqres.setHandler "default:region", ->
    App.mainRegion
  
  App.commands.setHandler "register:instance", (instance, id) ->
    App.register instance, id if App.environment is "development"
  
  App.commands.setHandler "unregister:instance", (instance, id) ->
    App.unregister instance, id if App.environment is "development"

  App.on "start", (options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) if @getCurrentRoute() is null

  App
  