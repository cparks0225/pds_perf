@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Test extends Entities.Model
    urlRoot: -> Routes.tests_path()

    runTest: ->
      @deferAction(@, (@get("interval") * @get("iteration") * 1000)).done (test) ->
        q.runQuery() for q in test.get("queries").models

  class Entities.TestsCollection extends Entities.Collection
    model: Entities.Test

    url: -> Routes.tests_path()

  API =
    getTests: ->
      tests = new Entities.TestsCollection
      tests.fetch
        reset: true
      tests

    getTest: (id) ->
      query = new Entities.Test
        id: id
      query.fetch()
      query

    newTest: ->
      new Entities.Test

    newTests: ->
      new Entities.TestsCollection

  App.reqres.setHandler "tests:entities", ->
    API.getTests()

  App.reqres.setHandler "tests:entity", (id) ->
    API.getTest id
 
  App.reqres.setHandler "new:tests:entities", ->
    API.newTests() 

  App.reqres.setHandler "new:tests:entity", ->
    API.newTest()
