jQuery ->
  $('#calendar').fullCalendar({
    defaultView: 'agendaWeek',
    events: '/pomodoros.json'
  })
