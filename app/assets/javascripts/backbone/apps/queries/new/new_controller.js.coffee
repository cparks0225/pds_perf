@PdsPerf.module "QueriesApp.New", (New, App, Backbone, Marionette, $, _) ->
  
  class New.Controller extends App.Controllers.Base
    
    initialize: =>
      pdsapis = App.request "pdsapi:entities"

      App.execute "when:fetched", [pdsapis], =>
        if pdsapis.length == 0
          console.log "MANUAL ENTRY"
          @layout = @getNewManualQueryView()
        else
          @layout = @getNewQueryView()
          
          @listenTo @layout, "button:refresh:swagger:clicked", =>
            @region.reset()
            @destroy()
            App.execute "disable:add:environment"
            $.get( "/pdsapis.json?refresh=true" )
              .done (data) => 
                App.execute "enable:add:environment"

          @listenTo @layout, "show", =>
            @apiListRegion pdsapis

        @listenTo @layout, "cancel:new:query:button:clicked", =>
          @region.reset()
          @destroy()

        @show @layout

    apiRestful: (restful) ->
      restfulView = @getRestfulView restful
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

    getNewManualQueryView: ->
      new New.ManualQuery

    getApisView: (pdsapis) ->
      new New.ApiList
        collection: pdsapis

    getRestfulView: (restful) ->
      new New.RestfulList
        model: restful
        