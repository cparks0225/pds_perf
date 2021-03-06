@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.LayoutView extends App.Views.LayoutView
    template: "environments/list/list_layoutview"
    id: "environments-list"

    regions:
      panelRegion: "#panel-region"
      newEnvironmentRegion: "#add-environment-region"
      environmentsRegion: "#environments-region"

  class List.Panel extends App.Views.ItemView
    template: "environments/list/_panel"

    triggers:
      "click #new-environment" : "new:environments:button:clicked"

  class List.Login extends App.Views.ItemView
    template: "environments/list/_login"

    triggers:
      "submit" : "login:submit"

  class List.Environment extends App.Views.ItemView
    template: "environments/list/_environment"
    tagName: "li"
    className: "list-group-item"

    triggers:
      "click .btn-danger" : "environments:delete:clicked"

  class List.NoEnvironment extends App.Views.ItemView
    template: "environments/list/_environment_not_selected"
    tagName: "li"
    className: "list-group-item text-center list-group-item-danger"

  class List.Empty extends App.Views.ItemView
    template: "environments/list/_empty"
    tagName: "li"
    className: "list-group-item text-center list-group-item-warning"

  class List.Environments extends App.Views.CompositeView
    template: "environments/list/_environments"
    childView: List.Environment
    childViewContainer: "ul"
    emptyView: List.Empty

  class List.EnvironmentForHeader extends App.Views.ItemView
    template: "environments/list/_environment_for_header"
    tagName: "li"

    events:
      "click" : (e) ->
        e.preventDefault()
        if @model.has "id"
          @trigger "environment:selected", @model
        else
          App.vent.trigger "page:selected", @model

  class List.EnvironmentsForHeader extends App.Views.CompositeView
    template: "environments/list/_environments_for_header"
    tagName: "ul"
    className: "nav navbar-nav"

    childView: List.EnvironmentForHeader
    childViewContainer: "#environments-list"

    templateHelpers: =>
      getTitle: =>
        ret = @collection.activeModel
        if @collection.activeModel == undefined
          ret = "Environment"
        else
          ret = ret.get("name")
        ret
