window.Tomatostats =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Tomatostats.Routers.Calendar()
    Backbone.history.start({pushState: true})

$(document).ready ->
  Tomatostats.initialize()
