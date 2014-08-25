@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Header extends Entities.Model

  class Entities.HeaderCollection extends Entities.Collection
    model: Entities.Header

  API =
    getHeaders: ->
      new Entities.HeaderCollection [
        { name: "Environment" }
        { name: "Results" }
        { name: "Suites" }
        { name: "Tests" }
        { name: "Appointments" }
      ]

  App.reqres.setHandler "header:entities", ->
    API.getHeaders()