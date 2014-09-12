@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.System extends Entities.Model
    urlRoot: -> Routes.systems_path()

  class Entities.SystemsCollection extends Entities.Collection
    model: Entities.System
    
    url: -> Routes.systems_path()

  API =
    getSystems: ->
      systems = new Entities.SystemsCollection
      systems.fetch
        reset: true
      systems 

    getSystem: (id) ->
      system = new Entities.System
        id: id
      system.fetch()
      system

    newSystem: ->
      new Entities.System

    newSystems: ->
      new Entities.SystemsCollection

  App.reqres.setHandler "systems:entity", (id) ->
    API.getSystem id

  App.reqres.setHandler "systems:entities", ->
    API.getSystems()
  
  App.reqres.setHandler "new:systems:entity", ->
    API.newSystem()

  App.reqres.setHandler "new:systems:entities", ->
    API.newSystems()