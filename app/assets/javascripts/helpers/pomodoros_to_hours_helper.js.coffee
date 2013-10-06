class Tomatostats.PomodorosToHoursHelper
  work: ->
    $('.pomodoros-count').each ->
      count = $(this).data('count')
      addTooltip(this, pomodorosToHours(count))

  toggleViews: ->
    if $('.pomodoros-count').first().data('format') == 'pomodoros'
      replacePomodorosWithHours()
    else
      resetPomodoros()


  replacePomodorosWithHours = ->
    $('.pomodoros-count').each ->
      count = $(this).data('count')
      $(this).data('pomodoros-text', $(this).text())
      addTooltip(this, $(this).text())
      $(this).text(pomodorosToHours(count))
      $(this).data('format', 'hours')

  resetPomodoros = ->
    $('.pomodoros-count').each ->
      $(this).text($(this).data('pomodoros-text'))
      count = $(this).data('count')
      addTooltip(this, pomodorosToHours(count))
      $(this).data('format', 'pomodoros')

  addTooltip = (element, content) ->
    $(element).tooltip('destroy')
    $(element).tooltip({
      title: content
    })

  pomodorosToHours= (count) ->
    hours_count = Math.round((count*25/60))
    return "~#{hours_count} hours"
