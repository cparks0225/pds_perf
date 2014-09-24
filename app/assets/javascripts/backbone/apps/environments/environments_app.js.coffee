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

    newNoEnvironmentSelectedView: (region) ->
      v = new EnvironmentsApp.List.NoEnvironment
      region.show(v)

    getSelectedEnvironment: ->
      App.request "environments:entity", App.getCookie "environment"

    setSelectedEnvironment: (environment) ->
      environment.collection.setActive(environment)

    deleteEnvironment: (environment) ->
      environment.destroy()

  App.commands.setHandler "new:environments:environment:view", (env) ->
    API.newEnvironment env

  App.vent.on "environments:delete:clicked", (environment) ->
    API.deleteEnvironment environment

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

  App.commands.setHandler "new:no:environment:selected:view", (region) ->
    API.newNoEnvironmentSelectedView region

  App.addInitializer ->
    new EnvironmentsApp.Router
      controller: API
