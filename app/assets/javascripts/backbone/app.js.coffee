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

  App.reqres.setHandler "get:system:selected", ->
    App.request "systems:entity", localStorage.getItem("swaggernautSystem")

  App.reqres.setHandler "get:environment:selected", ->
    App.request "environments:entity", localStorage.getItem("swaggernautEnvironment")

  App.reqres.setHandler "get:page:selected", ->
    localStorage.getItem("swaggernautPage")

  App.commands.setHandler "navigate", ->
    sys = App.request "get:system:selected"
    env = App.request "get:environment:selected"
    pag = App.request "get:page:selected"
    App.execute "when:fetched", [sys, env, pag], =>
      url = pag 
      url += sys.get("slug") if sys.get("slug")?
      url += env.get("slug") if env.get("slug")?
      console.log "NAVIGATE TO " + url
      App.navigate(url, trigger: true)

  App.on "start", (options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) if @getCurrentRoute() is null

  App
  