@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Pages extends Entities.Model

  class Entities.PagesCollection extends Entities.Collection
    model: Entities.Pages

  API =
    getPages: ->
      new Entities.PagesCollection [
        # { name: "Results", url: Routes.results_path() }
        { name: "Suites", url: Routes.suites_path() }
        { name: "Tests", url: Routes.tests_path() }
        { name: "Queries", url: Routes.queries_path() }
      ]

  App.reqres.setHandler "page:entities", ->
    API.getPages()
