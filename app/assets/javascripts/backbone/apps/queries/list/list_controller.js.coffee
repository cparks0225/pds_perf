@PdsPerf.module "QueryApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    listQueries: ->
      console.log "listQueries"
      queries = App.request "query:entities"
      console.log queries