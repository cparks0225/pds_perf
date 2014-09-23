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

  App.commands.setHandler "show:modal", (title, message) ->
    $('#modal_title').html(title)
    $('#modal_message').html(message)
    $('#modal_id').modal('show')

  App.commands.setHandler "show:error", (message, timeout) ->
    html = '<div class="container"><div class="alert alert-danger" role="alert"><center><div id="error_msg">'
    html += message
    html += '</div></center></div></div>'
    $('#error_div').html(html)
    $('#error_div').show()
    setTimeout (->
      $('#error_div').hide("slideUp")
      return
    ), timeout

  App.on "start", (options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) if @getCurrentRoute() is null

  App
  