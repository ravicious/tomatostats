class Tomatostats.Views.Calendar extends Backbone.View
  events:
    'click #delete_multiple': 'deleteMultiple'
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

  deleteMultiple: (event) ->
    event.preventDefault()
    if confirm("Are you sure?")
      sendRequest('delete_multiple')

  dateToInteger = (date) ->
    return Math.round(date / 1000)

  sendRequest = (type) ->
    if type == "assign"
      url = "/pomodoros/assign.json"
    else if type == "delete_multiple"
      url = "/pomodoros/delete_multiple.json"
    else
      throw "Unknown type of request. Try `assign` or `delete_multiple`."
    request = $.post url, $("#calendar-form").serialize()
    request.success (data) ->
      new Tomatostats.FlashMessage('success', data.message).render()
    request.error ->
      new Tomatostats.FlashMessage('warning', 'Something went wrong.').render()
    request.always ->
      $('#calendar').fullCalendar('refetchEvents')
