@PdsPerf.module "EnvironmentsApp", (EnvironmentsApp, App, Backbone, Marionette, $, _) ->

  class EnvironmentsApp.Router extends Marionette.AppRouter
    appRoutes:
      "environments" : "listEnvironments"

  API =
    listEnvironments: ->
      new EnvironmentsApp.List.Controller
      se = @getSelectedEnvironment()
      App.execute "when:fetched", [se], =>
        @highlightSelectedEnvironment( se.get("id") )

    newEnvironment: (region) ->
      new EnvironmentsApp.New.Controller
        region: region

    highlightSelectedEnvironment: (id) ->
      $("div").find("[data-id='env-" + id + "']").closest(".list-group").children(".list-group-item-info").removeClass("list-group-item-info");
      $("div").find("[data-id='env-" + id + "']").parent().addClass("list-group-item-info")

    getSelectedEnvironment: ->
      App.request "environments:entity", localStorage.getItem("pdsSelectedEnvironment")

    setSelectedEnvironment: (environment) ->
      localStorage.setItem("pdsSelectedEnvironment", environment.get("id"))
      @highlightSelectedEnvironment environment.get("id")

    login: (username, password, environment) ->
      data_string = "grant_type=password&username=" + username + "&password=" + password
      $.ajax
        type: "POST"
        url: environment.get('risklogin')
        data: data_string
        success: (msg) ->
          console.log "SUCCESS"
          console.log msg
          localStorage.setItem("auth_token", "SUCCESS")
          return
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          localStorage.setItem("auth_token", "ERR")
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
    console.log "environments_app.js.coffee::App.addInitializer:: Enter"
    new EnvironmentsApp.Router
      controller: API
    console.log "environments_app.js.coffee::App.addInitializer:: Leave"
