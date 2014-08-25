@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Query extends Entities.Model

  class Entities.QueriesCollection extends Entities.Collection
    model: Entities.Query

  API =
    setCurrentQuery: (currentQuery) ->
      new Entities.Query currentQuery

  App.reqres.setHandler "set:current:query", (currentQuery) ->
    API.setCurrentQuery currentQuery