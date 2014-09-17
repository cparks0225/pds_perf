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
      _.each @models, (m) =>
        if m.get("active")
          @activeModel = m.get("name")

      callback = @onResetCallbacks.pop()
      if callback
        callback this
        @fireResetCallbacks()
      return

    setActive: (system) ->
      _.each @models, (m) =>
        if m.get("id") == system.get("id")
          m.set("active", true)
          if m.get("id")?
            m.save
              active: true
            ,
              success: (m) =>
                @activeModel = m.get("name")
                App.vent.trigger "model:set:active", m
              error: ->
                console.log "SET ACTIVE SYSTEM ERROR!!!!!"
        else
          m.set("active", false)
          if m.get("id")?
            m.save()
        return