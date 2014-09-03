@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Environment extends Entities.Model
    urlRoot: -> Routes.environments_path()

  class Entities.EnvironmentsCollection extends Entities.Collection
    model: Entities.Environment

    url: -> Routes.environments_path()

  API =
    getEnvironments: ->
      environments = new Entities.EnvironmentsCollection
      environments.fetch
        reset: true
      environments

    getEnvironment: (id) ->
      environment = new Entities.Environment
        id: id
      environment.fetch()
      environment

    newEnvironment: ->
      new Entities.Environment

  App.reqres.setHandler "environments:entities", ->
    API.getEnvironments()

  App.reqres.setHandler "environments:entity", (id) ->
    API.getEnvironment id
  
  App.reqres.setHandler "new:environments:entity", ->
    API.newEnvironment()