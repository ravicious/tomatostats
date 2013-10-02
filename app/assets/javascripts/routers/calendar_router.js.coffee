class Tomatostats.Routers.Calendar extends Backbone.Router
  routes:
    '': 'index'
    'pomodoros': 'index'
    'projects/:id': 'project_page'

  index: ->
    console.log('this is an index!')
    calendar = new Tomatostats.Views.Calendar({path: '/pomodoros.json', el: '#calendar_wrapper'})
    calendar.render()

  project_page: (id) ->
    console.log("This is project #{id}")
