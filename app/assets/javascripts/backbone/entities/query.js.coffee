@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Query extends Entities.Model
    urlRoot: -> Routes.queries_path()

    runQuery: ->
      envs = App.request "environments:entities"

      App.execute "when:fetched", [envs], =>
        console.log "envs fetched"
        console.log envs
        @deferAction(@, (@get("interval") * @get("iteration") * 1000)).done (query) ->
          console.log "runQuery!"
          query_start_time = new Date().getTime()
          full_url = envs.activeModel.get("pds") + "/api" + query.get("url")

          query.set
            "resultStatus": "running"
            "runTime": query_start_time
            "environment": envs.activeModel.get("pds")

          # headers_obj =
          #   'Authorization': 'Bearer ' + localStorage.getItem("auth_token")

          $.ajax(
            type: query.get("method")
            url: full_url
            # headers: headers_obj
            
          ).done((data, textStatus, jqXHR) ->
            query_end_time = new Date().getTime()
            query.set
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
              "endTime": query_end_time 
              "resultStatus": textStatus
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
