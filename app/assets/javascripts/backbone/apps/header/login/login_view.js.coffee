@PdsPerf.module "HeaderApp.Login", (Login, App, Backbone, Marionette, $, _) ->

  class Login.Form extends App.Views.ItemView
    template: "header/login/login"
    id: "login-view"

    triggers: ->
      "submit" :"login"

  class Login.Logout extends App.Views.ItemView
    template: "header/login/logout"
    id: "login-view"

    triggers: ->
      "submit" : "logout"

  class Login.Wait extends App.Views.ItemView
    template: "header/login/wait"
    id: "login-view"
