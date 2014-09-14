@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Session extends Entities.Model
    urlRoot: -> Routes.sessions_path()

  API =
    getSession: (id) ->
      environment = new Entities.Session
        id: id
      environment.fetch()
      environment

    newSession: ->
      new Entities.Session

  App.reqres.setHandler "sessions:entity", (id) ->
    API.getSession id
  
  App.reqres.setHandler "new:sessions:entity", ->
    API.newSession()
    