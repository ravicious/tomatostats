class Tomatostats.Views.Calendar extends Backbone.View
  el: '#calendar_wrapper'

  initialize: ->
    this.$('.btn').attr('disabled', true)

  events:
    "click .btn": "showAlert"
    "change input": "changeButtons"
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
        $('#start').val(dateToInteger(startDate)).trigger('change')
        $('#end').val(dateToInteger(endDate)).trigger('change')
      eventDataTransform: (eventData) ->
        {
          title: eventData.project_name || "w/o project",
          allDay: false,
          start: eventData.started_at,
          end: eventData.finished_at
        }
    })

  changeButtons: (event) ->
    if event.target.value == ""
      this.$('.btn').attr('disabled', true)
    else
      this.$('.btn').removeAttr('disabled')

  showAlert: (event) ->
    event.preventDefault()
    alert("Ha, you tried pressing the button!")

  dateToInteger = (date) ->
    return Math.round(date / 1000)
