@PdsPerf.module "QueriesApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base
    
    initialize: ->
      # @query = App.request "new:queries:entity"
      pdsapis = App.request "pdsapi:entities"

      App.execute "when:fetched", [pdsapis], =>
        @layout = @getNewQueryView()

        @listenTo @layout, "show", =>
          @apiListRegion pdsapis

        @listenTo @layout, "cancel:new:query:button:clicked", =>
          @region.reset()
          @destroy()

        @show @layout

    apiRestful: (restful) ->
      restfulView = @getRestfulView restful

      # App.vent.on "new:queries:query:clicked", (e) =>
      #   console.log "create click"

        # query = @validateQuery( e.target )

        # console.log data
        # console.log restfulView.model
        # console.log restfulView.collection
        # restfulView.model.save data,
          # collection: restfulView.collection

      @layout.restfulsRegion.show restfulView

    apiListRegion: (pdsapis) ->
      apisView = @getApisView pdsapis

      apisView.on "childview:queries:api:clicked", (child, api) =>
        # Toggle the CSS to display the currently selected environment
        $(child.el).closest("tbody").children("tr").removeClass("list-group-item-info");
        $(child.el).addClass("list-group-item-info")

        @apiRestful api

      @layout.apiRegion.show apisView

    getNewQueryView: ->
      new New.QueryBuilder

    getApisView: (pdsapis) ->
      new New.ApiList
        collection: pdsapis

    getRestfulView: (restful) ->
      new New.RestfulList
        model: restful