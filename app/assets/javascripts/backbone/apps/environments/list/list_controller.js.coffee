@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  List.Controller =
    
    listEnvironments: ->
      environments = App.request "environments:entities"
      console.log environments
      @layout = @getLayoutView()

      @layout.on "show", =>
        @showLogin environments 
        @showEnvironments environments
        @showAddEnvironment()

      App.mainRegion.show @layout
    
    showLogin: (environments) ->
      loginView = @getLoginView environments
      @layout.loginRegion.show loginView

    showEnvironments: (environments) ->
      environmentsView = @getEnvironmentsView environments
      @layout.environmentsRegion.show environmentsView

    showAddEnvironment: ->
      addEnvironmentView = @getAddEnvironmentView()
      @layout.addEnvironmentRegion.show addEnvironmentView

    getLoginView: (environments) ->
      new List.Login
        collection: environments

    getEnvironmentsView: (environments) ->
      new List.Environments
        collection: environments

    getAddEnvironmentView: ->
      new List.AddEnvironment

    getLayoutView: ->
      new List.LayoutView