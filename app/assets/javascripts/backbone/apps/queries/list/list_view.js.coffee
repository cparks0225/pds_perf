@PdsPerf.module "QueryApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.LayoutView extends App.Views.LayoutView
    template: "queries/list/templates/list_layoutview"

    regions:
      panelRegion: "#panel-region"
      queriesRegion: "#queries-region"

  class List.Panel extends App.Views.ItemView
    template: "queries/list/templates/_panel"

  class List.Query extends App.Views.ItemView
    template: "queries/list/templates/_query"
    tagName: "tr"

  class List.Empty extends App.Views.ItemView
    template: "queries/list/templates/_empty"
    tagName: "tr"

  class List.Queries extends App.Views.CompositeView
    template: "queries/list/templates/_queries"
    childView: List.Query
    emptyView: List.Emtpy
    childViewContainer: "tbody"