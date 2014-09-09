@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Result extends Entities.Model
    urlRoot: -> Routes.results_path()

  class Entities.ResultsCollection extends Entities.Collection
    model: Entities.Result

    url: -> Routes.results_path()

  API =
    getResults: ->
      results = new Entities.ResultsCollection
      results.fetch
        reset: true
      results

    getResult: (id) ->
      query = new Entities.Result
        id: id
      query.fetch()
      query

    newResult: ->
      new Entities.Result

    newResults: ->
      new Entities.ResultsCollection

  App.reqres.setHandler "results:entities", ->
    API.getResults()

  App.reqres.setHandler "results:entity", (id) ->
    API.getResult id
 
  App.reqres.setHandler "new:results:entities", ->
    API.newResults() 

  App.reqres.setHandler "new:results:entity", ->
    API.newResult()
