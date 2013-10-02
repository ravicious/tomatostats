class Tomatostats.FlashMessage
  constructor: (@type, @message) ->

  render: ->
    $('#flash-messages').append(this.template())
    $('#flash-messages').find('.alert:last').slideDown()

  template: ->
    "<div style='display:none' class='alert alert-#{@type} alert-dismissable'>
      <button class='close' data-dismiss='alert' aria-hidden=''>&times;</button>
      #{@message}
    </div>"
