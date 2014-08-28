@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Environment extends Entities.Model

  class Entities.EnvironmentsCollection extends Entities.Collection
    model: Entities.Environment
    url: -> Routes.environments_path()

  API =
    getEnvironments: ->
      environments = new Entities.EnvironmentsCollection
      environments.fetch
        reset: true
      environments

    login: (user, pass) ->
      console.log "login!!!"
      console.log user
      console.log pass
      console.log App.request "get:selected:environment"

  App.commands.setHandler "login", (user, pass) ->
    API.login user, pass

  App.reqres.setHandler "environments:entities", ->
    API.getEnvironments()

