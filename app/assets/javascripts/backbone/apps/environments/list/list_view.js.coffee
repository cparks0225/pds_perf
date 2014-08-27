@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.LayoutView extends App.Views.LayoutView
    template: "environments/list/list_layoutview"
    id: "environments-list"

    regions:
      loginRegion: "#login-region"
      environmentsRegion: "#environments-region"
      addEnvironmentRegion: "#add-environment-region"

  class List.Login extends App.Views.ItemView
    template: "environments/list/_login"

  class List.Environment extends App.Views.ItemView
    template: "environments/list/_environment"
    tagName: "tr"

  class List.Environments extends App.Views.CompositeView
    template: "environments/list/_environments"
    childView: List.Environment
    childViewContainer: "tbody"

  class List.AddEnvironment extends App.Views.ItemView
    template: "environments/list/_add"
