@PdsPerf.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      @pages_links = App.request "page:entities"
      @system_links = App.request "systems:entities"

      App.execute "when:fetched", [@pages_links, @system_links], =>

        @layout = @getListLayout()

        App.headerRegion.listenTo @layout, "show", =>
          @showSystemsView()
          # @showEnvironmentsView()
          @showPagesView()

        console.log "show layout"
        App.headerRegion.show @layout
        console.log "layout shown"

    showPagesView: ->
      pagesView = @getPagesView()
      @layout.pagesRegion.show pagesView

    getListLayout: ->
      new List.LayoutView

    getPagesView: ->
      new List.Pages
        collection: @pages_links

    showSystemsView: ->
      App.execute "get:header:systems", @layout.systemsRegion, @system_links