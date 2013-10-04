class Tomatostats.Views.Project extends Backbone.View
  initialize: (@helper) ->
    @helper = new Tomatostats.PomodorosToHoursHelper()
  events:
    'click #toggle_views': 'toggleViews'
  render: ->
    @helper.work()
    return this
  toggleViews: (event) ->
    event.preventDefault()
    @helper.toggleViews()
    $(event.target).blur()
