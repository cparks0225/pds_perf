@PdsPerf.module "EnvironmentsApp", (EnvironmentsApp, App, Backbone, Marionette, $, _) ->

  class EnvironmentsApp.Router extends Marionette.AppRouter
    appRoutes:
      "environments" : "listEnvironments"

  API =
    listEnvironments: ->
      new EnvironmentsApp.List.Controller

    newEnvironment: (region) ->
      new EnvironmentsApp.New.Controller
        region: region

    getSelectedEnvironment: ->
      @selectedEnvironment

    setSelectedEnvironment: (environment) ->
      @selectedEnvironment = environment

    login: (username, password, environment) ->
      console.log "logging into environment"
      data_string = "grant_type=password&username=" + username + "&password=" + password
      console.log data_string
      $.ajax
        type: "POST"
        url: environment.get('risklogin')
        data: data_string
        success: (msg) ->
          console.log "SUCCESS"
          console.log msg
          return
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          environment.set "token", "HI"
          console.log environment
          alert "Failed to Login: " + errorThrown
          return

    deleteEnvironment: (environment) ->
      environment.destroy()

  App.reqres.setHandler "get:selected:environment", (environment) ->
    API.getSelectedEnvironment()

  App.commands.setHandler "new:environments:environment:view", (env) ->
    API.newEnvironment env

  App.vent.on "environments:environment:clicked", (environment) ->
    API.setSelectedEnvironment environment

  App.vent.on "environments:delete:clicked", (environment) ->
    API.deleteEnvironment environment

  App.commands.setHandler "login", (username, password, environment) ->
    API.login username, password, environment

  App.commands.setHandler "new:environments:entity", (region) ->
    API.newEnvironment region

  App.vent.on "environments:created", (environment) ->
    API.listEnvironments()

  App.addInitializer ->
    new EnvironmentsApp.Router
      controller: API
