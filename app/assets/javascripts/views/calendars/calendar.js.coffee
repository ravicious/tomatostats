class Tomatostats.Views.Calendar extends Backbone.View
  render: ->
    this.initializeCalendar(this.options.path)
    return this

  initializeCalendar: (path) ->
    this.$('#calendar').fullCalendar({
      defaultView: 'agendaWeek',
      selectable: true,
      allDaySlot: false,
      firstHour: 8,
      events: path,
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

  showAlert: (event) ->
    event.preventDefault()
    alert("Ha, you tried pressing the button!")

  dateToInteger = (date) ->
    return Math.round(date / 1000)
