$ ->
  $('[data-content-url]').each ->
    $.getScript $(this).data('content-url')
  
  $('#existing-messages').on 'click', '.user-name', ->
    $('#shoutbox_message_message').val($('#shoutbox_message_message').val().replace(/^(@\w+: )?/, "@#{$.trim($(this).text())} ")).focus()
    
  $('#existing-messages[data-stream-url]').each ->
    $(this).data('faye-client', new Faye.Client($(this).data('stream-url'))) unless $(this).data('faye-client')?
    $(this).data('faye-client').subscribe('/asc10/messages', (data) ->
      eval(data)
    )