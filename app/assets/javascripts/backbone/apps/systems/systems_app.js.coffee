
@PdsPerf.module "SystemsApp", (SystemsApp, App, Backbone, Marionette, $, _) ->

  class SystemsApp.Router extends Marionette.AppRouter
    appRoutes:
      "systems" : "listSystems"
      "systems/" : "listSystems"

  API =
    setSelectedSystem: (system) ->
      localStorage.setItem("System", system.get("id"))

      sess = App.request "sessions:entity"
      sess.set("system", system.get("id"))
      sess.save()

    listSystems: ->
      new SystemsApp.List.Controller

    newSystemsView: (region) ->
      new SystemsApp.New.Controller
        region: region

    newHeaderSystemsView: (region, systems) ->
      v = new SystemsApp.List.SystemsForHeader
        collection: systems

      v.on "childview:system:selected", (child, system) ->
        App.vent.trigger "system:selected", system
        $(v.el).find("#system-selected-name").html system.get("name") + '<span class="caret"></span>'

      region.show(v)

  App.commands.setHandler "new:systems:view", (region) ->
    API.newSystemsView region

  App.commands.setHandler "get:header:systems", (region, systems) ->
    API.newHeaderSystemsView region, systems

  App.vent.on "systems:created", ->
    API.listSystems()

  App.vent.on "system:selected", (system) ->
    API.setSelectedSystem system

  App.addInitializer ->
    new SystemsApp.Router
      controller: API
