jQuery ->
  $('#calendar').fullCalendar({
    defaultView: 'agendaWeek',
    selectable: true,
    events: '/pomodoros.json',
    eventDataTransform: (eventData) ->
      {
        title: eventData.project_name || "w/o project",
        allDay: false,
        start: eventData.started_at,
        end: eventData.finished_at
      }
  })
