@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Pages extends Entities.Model

  class Entities.PagesCollection extends Entities.Collection
    model: Entities.Pages

  API =
    getPages: ->
      new Entities.PagesCollection [
        # { name: "Results", slug: Routes.results_path() }
        { name: "Suites", slug: Routes.suites_path() }
        { name: "Tests", slug: Routes.tests_path() }
        { name: "Queries", slug: Routes.queries_path() }
      ]

  App.reqres.setHandler "page:entities", ->
    API.getPages()
