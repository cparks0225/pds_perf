@PdsPerf.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      @pages_links = App.request "page:entities"
      @system_links = App.request "systems:entities"
      @environments_links = App.request "environments:entities"

      App.execute "when:fetched", [@pages_links, @system_links, @environments_links], =>
        @layout = @getListLayout()

        App.headerRegion.listenTo @layout, "show", =>
          @showSystemsView()
          @showEnvironmentsView()
          @showLoginView()
          @showPagesView()

        App.headerRegion.show @layout

    showPagesView: ->
      pagesView = @getPagesView()

      @listenTo pagesView, "childview:page:selected", (child, page) ->
        App.vent.trigger "page:selected", page

      @layout.pagesRegion.show pagesView

    getListLayout: ->
      new List.LayoutView

    getPagesView: ->
      new List.Pages
        collection: @pages_links

    showLoginView: ->
      App.execute "get:login:view", @layout.loginRegion

    showSystemsView: ->
      App.execute "get:header:systems", @layout.systemsRegion, @system_links

    showEnvironmentsView: ->
      App.execute "get:header:environments", @layout.environmentsRegion, @environments_links
