@PdsPerf.module "EnvironmentsApp", (EnvironmentsApp, App, Backbone, Marionette, $, _) ->

  class EnvironmentsApp.Router extends Marionette.AppRouter
    appRoutes:
      "environments" : "adjustUrl"
      "environments/" : "adjustUrl"
      "environments/:system" : "listEnvironments"
      "environments/:system/:environment" : "adjustUrl"

  API =
    adjustUrl: ->
      current_system = App.request "get:system:selected"
      App.execute "when:fetched", [current_system], ->
        if current_system.has("name")
          App.navigate "/environments" + current_system.get("slug"), trigger:true
        else
          console.log "Navigating to env with no System selected"

    listEnvironments: ->
      new EnvironmentsApp.List.Controller

    newEnvironment: (region) ->
      new EnvironmentsApp.New.Controller
        region: region

    newHeaderEnvironmentsView: (region, environments) ->
      v = new EnvironmentsApp.List.EnvironmentsForHeader
        collection: environments

      v.on "childview:environment:selected", (child, environment) =>
        App.vent.trigger "environment:selected", environment
        $(v.el).find("#environment-selected-name").html environment.get("name") + '<span class="caret"></span>'

      region.show(v)

    getSelectedEnvironment: ->
      App.request "environments:entity", localStorage.getItem("swaggernautEnvironment")

    setSelectedEnvironment: (environment) ->
      localStorage.setItem("swaggernautEnvironment", environment.get("id"))

    # login: (username, password, environment) ->
    #   data_string = "grant_type=password&username=" + username + "&password=" + password
    #   $.ajax
    #     type: "POST"
    #     url: environment.get('risklogin')
    #     data: data_string
    #     success: (msg) ->
    #       console.log "SUCCESS"
    #       console.log msg
    #       localStorage.setItem("auth_token", "SUCCESS")
    #       return
    #     error: (XMLHttpRequest, textStatus, errorThrown) ->
    #       localStorage.setItem("auth_token", "ERR")
    #       alert "Failed to Login: " + errorThrown
    #       return

    deleteEnvironment: (environment) ->
      environment.destroy()

  App.commands.setHandler "new:environments:environment:view", (env) ->
    API.newEnvironment env

  # App.vent.on "environments:environment:clicked", (environment) ->
  #   API.setSelectedEnvironment environment

  App.vent.on "environments:delete:clicked", (environment) ->
    API.deleteEnvironment environment

  # App.commands.setHandler "login", (username, password, environment) ->
  #   API.login username, password, environment

  App.commands.setHandler "get:header:environments", (region, environments) ->
    API.newHeaderEnvironmentsView region, environments

  App.vent.on "environments:created", (environment) ->
    API.listEnvironments()

  App.commands.setHandler "new:environments:environment", (region) ->
    API.newEnvironment region

  App.vent.on "environment:selected", (environment) ->
    API.setSelectedEnvironment environment
    App.execute "navigate"

  App.addInitializer ->
    new EnvironmentsApp.Router
      controller: API
