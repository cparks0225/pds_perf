@PdsPerf.module "QueriesApp", (QueriesApp, App, Backbone, Marionette, $, _) ->

  class QueriesApp.Router extends Marionette.AppRouter
    appRoutes:
      "queries" : "listQueries"

  API =
    listQueries: ->
      new QueriesApp.List.Controller

    # listRestfuls: (api) ->
      # console.log "list restfuls for", api

    deleteQuery: (query) ->
      query.destroy()

    newQueryView: (region) ->
      new QueriesApp.New.Controller
        region: region

    serializeUrlParams: (data) ->
      param_string = ""
      $.each data, (i, v) ->
        if v.value isnt ""
          v["value"] = true  if v["value"] is "on"
          param_string = (if (param_string is "") then "?" else param_string + "&")
          param_string += v["name"] + "=" + v["value"]

      param_string

    serializeUrlPaths: (data, rule) ->
      url_path = ""
      counter = 0
      $.each data, (i, v) ->
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

      # Parse out any parameters that belong in the url path
      lmb = url.indexOf("{") # Left Most Bracket
      rmb = url.lastIndexOf("}") #Right Most Bracket

      api_pre = url.substr(0, lmb)
      api_post = url.substr(rmb + 1, url.length - rmb - 1)
      url_param_string = url.substr(lmb, rmb - lmb + 1)

      re_matched_params = url_param_string.match(/{(.*?)}/g)
      url_params = []
      url_param_keys = []
      re_matched_params = []  if re_matched_params is null
      $.each re_matched_params, (i, v) ->
        full_str = v.substr(1, v.length - 2)
        colon_pos = full_str.indexOf(":")
        url_params.push
          id: full_str.substr(0, colon_pos)
          regex: full_str.substr(colon_pos + 1, full_str.length)

        url_param_keys.push full_str.substr(0, colon_pos)

      param_objects = []
      url_values = []
      $.each data, (i, v) ->
        if $.inArray(i, url_param_keys) is -1
          param_objects.push
            name: i
            value: v
        else
          url_values.push 
            name: i
            value: v

      # Remove any existing validation classes on input fields
      $(query_form).find(".form-group").removeClass("has-error");
      $(query_form).find(".form-group").removeClass("has-success");

      # Verify that the submitted parameters match the regex pattern
      query_data = {}
      if API.verifyParamRegex(url_values, url_params)
        env = App.request "get:selected:environment"
        constructed_url = api_pre
        constructed_url += API.serializeUrlPaths(url_values, url_params)
        constructed_url += api_post
        # constructed_url += API.serializeUrlParams(param_objects)
        constructed_url = constructed_url.replace("//", "/").replace("../", "")

        query_data.url = constructed_url
        query_data.method = method
        query_data.data = param_objects

      # update the form with validation classes
      $.each url_values, (i, v) =>
        form_group_element = $(query_form).find("input[name='" + v["name"] + "']").parent().parent()
        form_group_element.addClass v["regex_match"]

      return query_data

    validateAddedQuery: (e) ->
      query = API.validateQuery( e.target )
      if "url" of query
        console.log "Query was successfully submitted"
        console.log query
        new_query = App.request "new:queries:entity"
        new_query.save query
        API.listQueries()
      else
        console.log "Errors during query validation"
        
  App.vent.on "queries:delete:clicked", (query) ->
    API.deleteQuery query

  App.vent.on "new:queries:query:clicked", (e) =>
    API.validateAddedQuery(e)

  # App.vent.on "queries:api:clicked", (query) ->
    # API.listRestfuls query

  App.commands.setHandler "new:queries:query:view", (region) ->
    API.newQueryView region 

  App.commands.setHandler "new:queries:query", (region) ->
    API.newQueryView region

  App.addInitializer ->
    new QueriesApp.Router
      controller: API