@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Collection extends Backbone.Collection

  class Entities.MenuCollection extends Entities.Collection
    constructor: ->
      args = arguments
      Backbone.Collection::constructor.apply this, args
      @onResetCallbacks = []
      @on "reset", @collectionReset, this
      return

    onReset: (callback) ->
      @onResetCallbacks.push callback
      @collectionLoaded and @fireResetCallbacks()
      return

    fireResetCallbacks: ->
      callback = @onResetCallbacks.pop()
      if callback
        callback this
        @fireResetCallbacks()
      return

    setActive: (system) ->
      _.each @models, (m) ->
        if m.get("id") == system.get("id")
          m.set("active", true)
        else
          m.set("active", false)
        if m.get("id")?
          m.save()
        return