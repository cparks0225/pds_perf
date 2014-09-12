@PdsPerf.module "SystemsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.LayoutView extends App.Views.LayoutView
    template: "systems/list/list_layoutview"
    id: "systems-list"

    regions:
      panelRegion: "#panel-region"
      newRegion: "#new-region"
      systemsRegion: "#systems-region"

  class List.PanelView extends App.Views.ItemView
    template: "systems/list/panel"

    triggers:
      "click #new-system" : "new:systems:button:clicked"

  class List.System extends App.Views.ItemView
    template: "systems/list/_system"
    tagName: "li"
    className: "list-group-item"

  class List.Systems extends App.Views.CompositeView
    template: "systems/list/systems"

    childView: List.System
    childViewContainer: "ul"

  class List.SystemForHeader extends App.Views.ItemView
    template: "systems/list/_system_for_header"
    tagName: "li"

  class List.SystemsForHeader extends App.Views.CompositeView
    template: "systems/list/_systems_for_header"
    tagName: "ul"
    className: "nav navbar-nav"

    childView: List.SystemForHeader
    childViewContainer: "#systems-list"

    onRender: ->
      console.log "ONRENDER"
      console.log $(@el).find("#systems-list")
      $(@el).find("#systems-list").append '<li class="divider"></li><li><a href="#/systems">Manage</a></li>'