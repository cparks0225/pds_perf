@PdsPerf.module "HeaderApp.Login", (Login, App, Backbone, Marionette, $, _) ->

  class Login.Controller extends App.Controllers.Base

    initialize: (region) ->
      @controller_region = region
      @existing_token = App.request "auth:entity", 1

      App.execute "when:fetched", [@existing_token], =>
        if (@existing_token.get "access_token") == ""
          @showLoginView()
        else
          @showLogoutView()

    login: (e) =>
      data = Backbone.Syphon.serialize e.view

      @showLoggingInView()

      new_auth = App.request "new:auth:entity"
      new_auth.save data,
        success: (m) =>
          @existing_token = m
          if m.get("access_token")?
            @showLogoutView()
          else
            @showLoginView()
        error: (m) =>
          @showLoginView()

    logout: =>
      logged_in_token = App.request "auth:entity", 1

      App.execute "when:fetched", [logged_in_token], =>
        logged_in_token.destroy
          success: =>
            @showLoginView()

    showLoginView: ->
      login_view = new Login.Form
        model: @existing_token

      @listenTo login_view, "login", (form) ->
        @login form

      @controller_region.show login_view

    showLoggingInView: ->
      wait_view = new Login.Wait
      @controller_region.show wait_view

    showLogoutView: ->
      logout_view = new Login.Logout

      @listenTo logout_view, "logout", (form) ->
        @logout()

      @controller_region.show logout_view
