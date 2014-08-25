@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Environment extends Entities.Model

  class Entities.EnvironmentsCollection extends Entities.Collection
    model: Entities.Environment
    url: -> Routes.environments_path()

  API =
    setCurrentEnvironment: (currentEnvironment) ->
      new Entities.Environment currentEnvironment

    getEnvironmentEntities: (cb) ->
      environments = new Entities.EnvironmentsCollection
      environments.fetch
        success: ->
          cb environments

  App.reqres.setHandler "set:current:environment", (currentEnvironment) ->
    API.setCurrentEnvironment currentEnvironment

  App.reqres.setHandler "environment:entities", (cb) ->
    console.log( "2" )
    API.getEnvironmentEntities cb