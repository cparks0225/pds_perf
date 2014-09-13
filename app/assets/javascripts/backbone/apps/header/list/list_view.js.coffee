@PdsPerf.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.LayoutView extends App.Views.LayoutView
    template: "header/list/headers"

    regions:
      systemsRegion: "#systems-region"
      environmentsRegion: "#environments-region"
      pagesRegion: "#pages-region"

  class List.Page extends App.Views.ItemView
    template: "header/list/_page"
    tagName: "li"

    events:
      "click" : (e) ->
        e.preventDefault()
        @trigger "page:selected", @model

  class List.Pages extends App.Views.CompositeView
    template: "header/list/pages"
    childView: List.Page
    childViewContainer: "#pages-list"
