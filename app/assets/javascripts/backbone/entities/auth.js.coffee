@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Auth extends Entities.Model
    urlRoot: -> "/auth"

  API =
    getAuth: (id) ->
      auth = new Entities.Auth
        id: id
      auth.fetch()
      auth

    newAuth: ->
      new Entities.Auth

  App.reqres.setHandler "auth:entity", (id) ->
    API.getAuth id
  
  App.reqres.setHandler "new:auth:entity", ->
    API.newAuth()
