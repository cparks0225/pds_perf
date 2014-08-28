@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  List.Controller =
    
    listEnvironments: ->
      environments = App.request "environments:entities"
      @layout = @getLayoutView()

      @layout.on "show", =>
        @loginRegion environments 
        @environmentsRegion environments
        @newEnvironmentRegion()

      App.execute "when:fetched", [environments], =>
        App.mainRegion.show @layout
    
    loginRegion: (environments) ->
      loginView = @getLoginView environments

      loginView.on "environments:environment:login:clicked", (model) ->
        console.log "login clicked"
        console.log model
        App.commands.execute "login", "u", "p"

      @layout.loginRegion.show loginView

    environmentsRegion: (environments) ->
      environmentsView = @getEnvironmentsView environments

      environmentsView.on "childview:environments:environment:clicked", (child, environment) ->
        # Toggle the CSS to display the currently selected environment
        $(child.el).closest(".list-group").children(".list-group-item-info").removeClass("list-group-item-info");
        $(child.el).addClass("list-group-item-info")

        # Pass the event on up to the environments application
        App.vent.trigger "environments:environment:clicked", environment

      @layout.environmentsRegion.show environmentsView

    newEnvironmentRegion: ->
      newEnvironmentView = App.request "new:environments:environment:view"
      @layout.newEnvironmentRegion.show newEnvironmentView

    getLoginView: (environments) ->
      new List.Login
        collection: environments

    getEnvironmentsView: (environments) ->
      new List.Environments
        collection: environments

    getLayoutView: ->
      new List.LayoutView