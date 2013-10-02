class Tomatostats.Views.Calendar extends Backbone.View
  events:
    'click #delete_multiple': 'deleteMultiple'
    'click #assign': 'assign'
    'click #unassign': 'unassign'
  render: ->
    this.initializeCalendar(this.options.path)
    return this

  initializeCalendar: (path) ->
    this.$('#calendar').fullCalendar({
      defaultView: 'agendaWeek',
      selectable: true,
      allDaySlot: false,
      unselectAuto: false,
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

  deleteMultiple: (event) ->
    event.preventDefault()
    if confirm("Are you sure?")
      sendRequest('/pomodoros/delete_multiple.json')

  assign: (event) ->
    event.preventDefault()
    sendRequest('/pomodoros/assign.json')

  unassign: (event) ->
    event.preventDefault()
    sendRequest('/pomodoros/unassign.json')

  dateToInteger = (date) ->
    return Math.round(date / 1000)

  sendRequest = (url) ->
    request = $.post url, $("#calendar-form").serialize()
    request.success (data) ->
      new Tomatostats.FlashMessage('success', data.message).render()
    request.error (jqXHR) ->
      new Tomatostats.FlashMessage('warning', jqXHR.responseJSON.message).render()
    request.always ->
      $('#calendar').fullCalendar('refetchEvents')
