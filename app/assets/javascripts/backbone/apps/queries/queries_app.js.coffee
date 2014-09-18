@PdsPerf.module "QueriesApp", (QueriesApp, App, Backbone, Marionette, $, _) ->

  class QueriesApp.Router extends Marionette.AppRouter
    appRoutes:
      "queries" : "listQueries"
      "queries/" : "listQueries"

  API =
    listQueries: (system)->
      new QueriesApp.List.Controller

    listQueriesForTests: (queries) ->
      new QueriesApp.List.QueriesForTests
        collection: queries

    deleteQuery: (query) ->
      query.destroy()

    newQueryView: (region) ->
      new QueriesApp.New.Controller
        region: region

    serializeUrlParams: (data) ->
      param_string = ""
      $.each data, (i, v) ->
        if v.value isnt ""
          v["value"] = true if v["value"] is "on"
          param_string = (if (param_string is "") then "?" else param_string + "&")
          param_string += v["name"] + "=" + v["value"]

      param_string

    serializeUrlPaths: (data, rule, input_to_model_map) ->
      # First compare individual fields to model map, smash together if necessary
      new_data = []
      new_data_objs = {}
      $.each data, (i, v) ->
        if Object.prototype.hasOwnProperty.call(new_data_objs, input_to_model_map[v.name]) == false
          new_data_objs[input_to_model_map[v.name]] =
            name: input_to_model_map[v.name]
            value: v.value
        else
          new_data_objs[input_to_model_map[v.name]].value += v.value

      $.each new_data_objs, (i,v) ->
        new_data.push v

      url_path = ""
      counter = 0
      $.each new_data, (i, v) ->
        url_path = (if (counter is 0) then "" else url_path + ":")
        url_path += v["value"]
        counter++

      url_path

    verifyParamRegex: ( url_path_params, regex ) ->
      ret_val = true
      $.each url_path_params, (i,v) ->
        $.each regex, (j,y) ->
          if y['id'] == v['name']
            search_regex = v['value'].match y['regex']
            if not search_regex?
              v['regex_match'] = "has-error"
              ret_val = false
            else
              v['regex_match'] = "has-success"
      return ret_val;

    validateQuery: (query_form) =>
      data = Backbone.Syphon.serialize query_form
      method = query_form.dataset['method']
      url = query_form.dataset['url']

      console.log "validateQuery"
      console.log query_form
      console.log data


      # Parse out any parameters that belong in the url path
      lmb = url.indexOf("{")      # Left Most Bracket
      rmb = url.lastIndexOf("}")  #Right Most Bracket

      api_pre = url.substr(0, lmb)
      api_post = url.substr(rmb + 1, url.length - rmb - 1)
      url_param_string = url.substr(lmb, rmb - lmb + 1)

      re_matched_params = url_param_string.match(/{(.*?)}/g)
      url_params = []
      url_param_keys = []

      re_matched_params = [] if re_matched_params is null
      $.each re_matched_params, (i, v) ->
        full_str = v.substr(1, v.length - 2)
        colon_pos = full_str.indexOf(":")
        if colon_pos == -1
          colon_pos = full_str.length 
        url_params.push
          id: full_str.substr(0, colon_pos)
          regex: full_str.substr(colon_pos + 1, full_str.length)

        url_param_keys.push full_str.substr(0, colon_pos)




      # Distinguish the url values from request data objects
      data_objects = []       # Input values associated with each request input for data submission
      param_objects = []      # Input values associated with each request input for url serialization
      url_values = []         # Input values associated with each url path in brackets, i.e. {id}
      input_to_model_map = {} # Map of each primitive to it's parameter name
      input_to_type_map = {}  # Map of each primitive to it's paramType (path/body)

      $.each data, (i, v) ->
        input_to_model_map[i] = $(query_form).find("input[name='" + i + "']").data("model")
        input_to_type_map[i] = $(query_form).find("input[name='" + i + "']").data("paramtype")

        console.log "SWITCH: " + input_to_type_map[i]
        switch input_to_type_map[i]
          when "path"
            url_values.push 
              name: i
              value: v
          when "query"
            param_objects.push
              name: i
              value: v
          when "body"
            data_objects.push
              name: i
              value: v

      console.log "input_to_model_map"
      console.log input_to_model_map

      console.log "input_to_type_map"
      console.log input_to_type_map

      console.log "param_objects"
      console.log param_objects

      console.log "data_objects"
      console.log data_objects

      console.log "url_values"
      console.log url_values

      # Remove any existing validation classes on input fields
      $(query_form).find(".form-group").removeClass("has-error");
      $(query_form).find(".form-group").removeClass("has-success");

      # Verify that the submitted parameters match the regex pattern
      query_data = {}
      if API.verifyParamRegex(url_values, url_params)
        constructed_url = api_pre
        constructed_url += API.serializeUrlPaths(url_values, url_params, input_to_model_map)
        constructed_url += api_post
        constructed_url += API.serializeUrlParams(param_objects)
        constructed_url = constructed_url.replace("//", "/").replace("../", "")

        query_data.url = constructed_url
        query_data.method = method
        query_data.data = data_objects

      # update the form with validation classes
      $.each url_values, (i, v) =>
        form_group_element = $(query_form).find("input[name='" + v["name"] + "']").parent().parent()
        form_group_element.addClass v["regex_match"]

      return query_data

    validateAddedQuery: (e) ->
      query = API.validateQuery( e.target )
      if "url" of query
        new_query = App.request "new:queries:entity"
        new_query.save query
        API.listQueries()
        
  App.vent.on "queries:delete:clicked", (query) ->
    API.deleteQuery query

  App.vent.on "new:queries:query:clicked", (e) =>
    API.validateAddedQuery(e)

  App.reqres.setHandler "tests:queries:view", (queries) ->
    API.listQueriesForTests queries

  App.commands.setHandler "new:queries:query:view", (region) ->
    API.newQueryView region 

  App.commands.setHandler "new:queries:query", (region) ->
    API.newQueryView region

  App.reqres.setHandler "queries:query:data:stringify", (obj) ->
    new_data = []
    if obj?
      for val, idx in obj
        new_obj = {}
        new_obj[val.name] = val.value
        new_data.push new_obj

    return JSON.stringify new_data

  App.vent.on "model:set:active", (system) ->
    if not ((Routes.queries_path().indexOf(App.getCurrentRoute())) == -1)
      API.listQueries()

  App.addInitializer ->
    new QueriesApp.Router
      controller: API
