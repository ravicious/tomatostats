class Tomatostats.Routers.Calendar extends Backbone.Router
  routes:
    '': 'index'
    '_=_': 'index'
    'pomodoros': 'index'
    'projects/:id': 'project_page'

  index: ->
    calendar = new Tomatostats.Views.Calendar({path: '/pomodoros.json', el: '#calendar_wrapper'})
    calendar.render()

  project_page: (id) ->
    project = new Tomatostats.Views.Project({el: '#project'})
    project.render()
