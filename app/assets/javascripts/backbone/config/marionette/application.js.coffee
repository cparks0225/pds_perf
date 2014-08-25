do (Backbone) ->

  _.extend Backbone.Marionette.Application::, 

    navigate: (route, options = {}) ->
      console.log "navigate"
      console.log route
      route = "#" + route if route.charAt(0) is "/"
      Backbone.history.navigate route, options

    getCurrentRoute: ->
      console.log "getCurrentRoute"
      frag = Backbone.history.fragment
      console.log frag
      if _.isEmpty(frag) then null else frag
