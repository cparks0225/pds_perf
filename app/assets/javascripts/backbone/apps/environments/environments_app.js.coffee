@PdsPerf.module "EnvironmentsApp", (EnvironmentsApp, App, Backbone, Marionette, $, _) ->

  class EnvironmentsApp.Router extends Marionette.AppRouter
    appRoutes:
      "environments" : "listEnvironments"
      "environments/" : "listEnvironments"

  API =
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
      App.request "environments:entity", App.getCookie "environment"

    setSelectedEnvironment: (environment) ->
      environment.collection.setActive(environment)

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

  App.vent.on "environments:delete:clicked", (environment) ->
    API.deleteEnvironment environment

  # App.commands.setHandler "login", (username, password, environment) ->
  #   API.login username, password, environment

  App.commands.setHandler "get:header:environments", (region, environments) ->
    v = API.newHeaderEnvironmentsView region, environments

  App.vent.on "environments:created", (environment) ->
    API.listEnvironments()

  App.commands.setHandler "new:environments:environment", (region) ->
    API.newEnvironment region

  App.vent.on "environment:selected", (environment) ->
    API.setSelectedEnvironment environment

  App.vent.on "model:set:active", (m) =>
    if not ((Routes.environments_path().indexOf(App.getCurrentRoute())) == -1)
      API.listEnvironments()

  App.addInitializer ->
    new EnvironmentsApp.Router
      controller: API
