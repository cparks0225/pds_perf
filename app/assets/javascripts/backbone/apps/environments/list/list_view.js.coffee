@PdsPerf.module "EnvironmentsApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.LayoutView extends App.Views.LayoutView
    template: "environments/list/templates/list_layoutview"

    regions:
      panelRegion: "#panel-region"
      environmentsRegion: "#environments-region"

  class List.Panel extends App.Views.ItemView
    template: "environments/list/templates/_panel"

  class List.Environment extends App.Views.ItemView
    template: "environments/list/templates/_environment"
    tagName: "tr"

  class List.Environments extends App.Views.CompositeView
    template: "environments/list/templates/_environments"
    childView: List.Environment
    childViewContainer: "tbody"