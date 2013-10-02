class Tomatostats.FlashMessage
  constructor: (@type, @message) ->

  render: ->
    $('#flash-messages').empty().append(this.template()).find('.alert').fadeIn()

  template: ->
    "<div style='display:none' class='alert alert-#{@type} alert-dismissable'>
      <button class='close' data-dismiss='alert' aria-hidden=''>&times;</button>
      #{@message}
    </div>"
