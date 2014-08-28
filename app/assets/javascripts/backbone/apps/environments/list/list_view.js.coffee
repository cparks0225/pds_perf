@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.LayoutView extends App.Views.LayoutView
    template: "environments/list/list_layoutview"
    id: "environments-list"

    regions:
      loginRegion: "#login-region"
      environmentsRegion: "#environments-region"
      newEnvironmentRegion: "#add-environment-region"

  class List.Login extends App.Views.ItemView
    template: "environments/list/_login"

    triggers:
      "click #login" : ->
        console.log @model
        # "environments:environment:login:clicked", @model

  class List.Environment extends App.Views.ItemView
    template: "environments/list/_environment"
    tagName: "li"
    className: "list-group-item"

    events:
      "click" : -> @trigger "environments:environment:clicked", @model

  class List.Empty extends App.Views.CompositeView
    template: "environments/list/_empty"
    tagName: "li"
    className: "list-group-item text-center list-group-item-warning"

  class List.Environments extends App.Views.CompositeView
    template: "environments/list/_environments"
    childView: List.Environment
    childViewContainer: "ul"
    emptyView: List.Empty
