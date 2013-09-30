jQuery ->
  $('#calendar').fullCalendar({
    defaultView: 'agendaWeek',
    selectable: true,
    allDaySlot: false,
    firstHour: 8,
    events: '/pomodoros.json',
    select: (startDate, endDate) ->
      $('#start').val(dateToInteger(startDate))
      $('#end').val(dateToInteger(endDate))
    eventDataTransform: (eventData) ->
      {
        title: eventData.project_name || "w/o project",
        allDay: false,
        start: eventData.started_at,
        end: eventData.finished_at
      }
  })

dateToInteger = (date) ->
  return Math.round(date / 1000)
