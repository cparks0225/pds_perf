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

  class List.Empty extends App.Views.CompositeView
    template: "environments/list/_empty"
    tagName: "li"
    className: "list-group-item text-center list-group-item-warning"

  class List.Environments extends App.Views.CompositeView
    template: "environments/list/_environments"
    childView: List.Environment
    childViewContainer: "ul"
    emptyView: List.Empty

    # onRender: ->
    #   current_system = App.request "get:system:selected"
    #   App.execute "when:fetched", [current_system], =>
    #     if not current_system.has("name")
    #       $(@el).find("li").addClass "list-group-item-danger"
    #       $(@el).find("h4").html "No System Selected"

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
    # onRender: ->
    #   current_env = App.request "get:environment:selected"
    #   App.execute "when:fetched", [current_env], =>
    #     if current_env.has("name")
    #       $(@el).find("#environment-selected-name").html current_env.get("name") + '<span class="caret"></span>'
