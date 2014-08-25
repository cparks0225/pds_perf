@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Header extends Entities.Model

  class Entities.HeaderCollection extends Entities.Collection
    model: Entities.Header

  API =
    getHeaders: ->
      new Entities.HeaderCollection [
        { name: "Environments", url: Routes.environments_path() }
        { name: "Results", url: Routes.results_path() }
        { name: "Suites", url: Routes.suites_path() }
        { name: "Tests", url: Routes.tests_path() }
        { name: "Queries", url: Routes.queries_path() }
      ]

  App.reqres.setHandler "header:entities", ->
    API.getHeaders()