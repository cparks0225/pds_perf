@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Query extends Entities.Model
    urlRoot: -> Routes.queries_path()

    testUrl: ->
      console.log "testUrl"
      run_env = App.request "get:selected:environment"
      console.log run_env
      full_url = run_env.get("pds") + "/api" + @.get("url")
      console.log full_url
      full_url

    runQuery: ->
      @deferAction(@, (@get("interval") * @get("iteration") * 1000)).done (query) ->
        query_start_time = new Date().getTime()

        console.log "run query"
        console.log query
        $.ajax(
          type: query.get("method")
          url: query.testUrl()
        ).done((data, textStatus, jqXHR) ->
          query_end_time = new Date().getTime()
          query.set
            "runTime": query_start_time
            "endTime": query_end_time 
            "resultStatus": textStatus
            "ajax": Math.abs(query_end_time - query_start_time)
            "con": data.result.time.con
            "parse": data.result.time.parse
            "q": data.result.time.q
            "qc": data.result.time.qc

        ).fail (jqXHR, textStatus, errorThrown) ->
          query_end_time = new Date().getTime()
          query.set
            "restulStatus": textStatus
            "ajax": Math.abs(query_end_time - query_start_time)
            "con": 0
            "parse": 0
            "q": 0
            "qc": 0

  class Entities.QueriesCollection extends Entities.Collection
    model: Entities.Query

    url: -> Routes.queries_path()

  API =
    getQueries: ->
      queries = new Entities.QueriesCollection
      queries.fetch
        reset: true
      queries

    getQuery: (id) ->
      query = new Entities.Query
        id: id
      query.fetch()
      query

    newQuery: ->
      new Entities.Query

    newQueries: ->
      new Entities.QueriesCollection

  App.reqres.setHandler "queries:entity", (id) ->
    API.getQuery id

  App.reqres.setHandler "queries:entities", ->
    API.getQueries()
  
  App.reqres.setHandler "new:queries:entity", ->
    API.newQuery()

  App.reqres.setHandler "new:queries:entities", ->
    API.newQueries()
