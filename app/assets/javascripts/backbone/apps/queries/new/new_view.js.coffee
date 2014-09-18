@PdsPerf.module "QueriesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.QueryBuilder extends App.Views.LayoutView
    template: "queries/new/query_builder"
    class: "panel-body"

    regions:
      apiRegion: "#apis-region"
      restfulsRegion: "#restfuls-region"

    triggers:
      "click #cancel-new-query" : "cancel:new:query:button:clicked"

  class New.Query extends App.Views.ItemView
    template: "queries/new/_api"
    tagName: "tr"

    events:
      "click" : -> @trigger "queries:api:clicked", @model

  class New.ApiList extends App.Views.CompositeView
    template: "queries/new/api_list"

    childView: New.Query
    childViewContainer: "tbody"

  class New.RestfulParamPrimitive extends App.Views.ItemView
    template: "queries/new/_primitive_int"

  class New.RestfulList extends App.Views.ItemView
    template: "queries/new/restful_list"
    class: "panel-group"

    onShow: ->
      $(@.$el).find("form").unbind()
      $(@.$el).find("form").submit (e) ->
        e.preventDefault()
        App.vent.trigger "new:queries:query:clicked", e

    templateHelpers:
      renderParams: (obj, models, unique_id) =>
        return_val = ""

        primitives = ['long', 'Short', 'int', 'string', 'Date', 'Map[string,string]', 'boolean']
        number_types = ['long', 'Short', 'int']
        template_path = "backbone/apps/queries/new/templates/"

        if "parameters" of obj
          for param in obj.parameters
            r = ""
            if $.inArray(param.dataType, primitives) != -1
              return_val += "<hr>"
              param['inputType'] = param.dataType
              if not param['name']?
                param['name'] = param['dataType']

              param['dataModel'] = param.name
              param['paramType'] = param.paramType
              param['unique_id'] = param['name'] + "-" + unique_id
              switch param.dataType
                when "boolean" then param['inputType'] = "checkbox"
                when "int" then param['inputType'] = "number"
                when "long" then param['inputType'] = "number"
                when "Short" then param['inputType'] = "number"
                when "Map[string,string]" then param['inputType'] = "string"
              r = JST[template_path + "_primitive"](param)
              return_val += r
            else
              if param.dataType of models
                return_val += "<hr><div><h4>"
                if param.name == null
                  param.name = param.dataType

                return_val += param.name + "</h4></div>"
                for sub_param_key of models[param.dataType]["properties"]
                  sub_param = models[param.dataType]["properties"][sub_param_key]
                  sub_param['name'] = sub_param_key
                  sub_param['unique_id'] = sub_param['name'] + "-" + unique_id
                  sub_param['dataType'] = sub_param['type']
                  sub_param['dataModel'] = param.name
                  sub_param['paramType'] = param.paramType
                  r = ""
                  if $.inArray(sub_param.dataType, primitives) != -1
                    sub_param['inputType'] = sub_param.dataType
                    switch sub_param["dataType"]
                      when "boolean" then sub_param['inputType'] = "checkbox"
                      when "int" then sub_param['inputType'] = "number"
                      when "long" then sub_param['inputType'] = "number"
                      when "Short" then sub_param['inputType'] = "number"
                      when "Map[string,string]" then sub_param['inputType'] = "string"
                    r = JST[template_path + "_primitive"](sub_param)
                  return_val += r

        return return_val
