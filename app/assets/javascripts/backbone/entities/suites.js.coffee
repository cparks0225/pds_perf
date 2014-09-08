@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Suite extends Entities.Model
    urlRoot: -> Routes.suites_path()

  class Entities.SuitesCollection extends Entities.Collection
    model: Entities.Suite

    url: -> Routes.suites_path()

  API =
    getSuites: ->
      suites = new Entities.SuitesCollection
      suites.fetch
        reset: true
      suites

    getSuite: (id) ->
      query = new Entities.Suite
        id: id
      query.fetch()
      query

    newSuite: ->
      new Entities.Suite

  App.reqres.setHandler "suites:entities", ->
    API.getSuites()

  App.reqres.setHandler "suites:entity", (id) ->
    API.getSuite id
  
  App.reqres.setHandler "new:suites:entity", ->
    API.newSuite()
