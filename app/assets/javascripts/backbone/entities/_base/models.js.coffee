@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Model extends Backbone.Model

    destroy: (options = {}) ->
      _.defaults options,
        wait: true
      
      @set _destroy: true
      super options
    
    isDestroyed: ->
      @get "_destroy"
    
    save: (data, options = {}) ->
      console.log "entities:_base:models:save"
      isNew = @isNew()

      console.log @
      
      _.defaults options,
        wait: true
        success:  _.bind(@saveSuccess, @, isNew, options.collection)
        error:    _.bind(@saveError, @)
    
      @unset "_errors"
      super data, options
    
    saveSuccess: (isNew, collection) =>
      console.log "entities:_base:models:saveSuccess"
      if isNew ## model is being created
        collection.add @ if collection
        collection.trigger "model:created", @ if collection
        @trigger "created", @
      else ## model is being updated
        collection ?= @collection ## if model has collection property defined, use that if no collection option exists
        collection.trigger "model:updated", @ if collection
        @trigger "updated", @
    
    saveError: (model, xhr, options) =>
      console.log "entities:_base:models:saveError"
      ## set errors directly on the model unless status returned was 500 or 404
      @set _errors: $.parseJSON(xhr.responseText)?.errors unless xhr.status is 500 or xhr.status is 404