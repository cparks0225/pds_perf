@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Controller extends App.Controllers.Base
    
    initialize: ->
      environments = App.request "environments:entities"

      App.execute "when:fetched", [environments], =>

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @loginRegion()
          @environmentsRegion environments
          @newEnvironmentRegion()

        @show @layout
    
    loginRegion: ->
      loginView = @getLoginView()

      loginView.on "login:submit", ->
        env = App.request "get:selected:environment"
        data = Backbone.Syphon.serialize loginView
        if env != undefined
          App.commands.execute "login", data['username'], data['password'], env
        else
          alert "Select an Environment to login to"
      @layout.loginRegion.show loginView

    environmentsRegion: (environments) ->
      environmentsView = @getEnvironmentsView environments

      environmentsView.on "childview:environments:environment:clicked", (child, environment) ->
        # Toggle the CSS to display the currently selected environment
        $(child.el).closest(".list-group").children(".list-group-item-info").removeClass("list-group-item-info");
        $(child.el).addClass("list-group-item-info")

        # Pass the event on up to the environments application
        App.vent.trigger "environments:environment:clicked", environment

      environmentsView.on "childview:environments:delete:clicked", (child) ->
        console.log "delete on"
        App.vent.trigger "environments:delete:clicked", child.model

      @layout.environmentsRegion.show environmentsView

    newEnvironmentRegion: ->
      newEnvironmentView = App.execute "new:environments:environment:view", @layout.newEnvironmentRegion

    getLoginView: ->
      new List.Login

    getEnvironmentsView: (environments) ->
      new List.Environments
        collection: environments

    getLayoutView: ->
      new List.LayoutView
