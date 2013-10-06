class Tomatostats.Views.Project extends Backbone.View
  initialize: (@helper) ->
    @helper = new Tomatostats.PomodorosToHoursHelper()
  events:
    'click #toggle_views': 'toggleViews'
  render: ->
    @helper.work()
    renderCalendars()
    addEventsToCalendars()
    return this
  toggleViews: (event) ->
    event.preventDefault()
    @helper.toggleViews()
    $(event.target).blur()

  renderCalendars = ->
    $('.tiny-calendar').each ->
      $(this).fullCalendar({
        theme: true
        header:
          left: ''
          center: ''
          right: ''
        firstDay: 1
      })
      date = new Date($(this).data('date'))
      $(this).fullCalendar('gotoDate', date)

  addEventsToCalendars = ->
    $('.tiny-calendar').each ->
      events = []
      $(this).find('.event').each ->
        events.push({
          title: 'Pomodoro'
          start: $(this).find('.start').text()
          end: $(this).find('.end').text()
        })
      $(this).fullCalendar('addEventSource', events)
