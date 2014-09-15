@PdsPerf.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Environment extends Entities.Model
    urlRoot: -> Routes.environments_path()

  class Entities.EnvironmentsCollection extends Entities.MenuCollection
    model: Entities.Environment

    url: -> 
      Routes.environments_path()

    collectionReset: ->
      @collectionLoaded = true  unless @collectionLoaded

      div = new Entities.Environment
      div.set
        name: "Divider"
        riskapi: ""
        pds: ""
        slug: ""
      @add div

      manage_item = new Entities.Environment
      manage_item.set
        name: "Manage"
        riskapi: ""
        pds: ""
        slug: "/environments"
      @add manage_item

      @fireResetCallbacks()
      return

  API =
    getEnvironments: ->
      environments = new Entities.EnvironmentsCollection
      environments.fetch
        reset: true
      environments

    getEnvironment: (id) ->
      environment = new Entities.Environment
        id: id
      environment.fetch()
      environment

    newEnvironments: ->
      new Entities.EnvironmentsCollection

    newEnvironment: ->
      new Entities.Environment

  App.reqres.setHandler "environments:entities", ->
    API.getEnvironments()

  App.reqres.setHandler "environments:entity", (id) ->
    API.getEnvironment id
  
  App.reqres.setHandler "new:environments:entities", ->
    API.newEnvironments()

  App.reqres.setHandler "new:environments:entity", ->
    API.newEnvironment()
    