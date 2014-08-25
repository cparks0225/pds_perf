@PdsPerf.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.ItemView extends Marionette.ItemView

    serializeData: ->
      ## can handle custom stuff here
      super