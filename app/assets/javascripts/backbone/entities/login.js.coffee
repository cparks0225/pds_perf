@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Login extends Entities.Model

  API =
    getLoginToken: (user, pass) ->
      environments = new Entities.EnvironmentsCollection
      environments.fetch
        reset: true
      environments

  App.reqres.setHandler "environments:environment:login", ->
    API.getLoginToken 