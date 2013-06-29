$ ->
  $('[data-content-url]').each ->
    $.getScript $(this).data('content-url')
  
  $('#existing-messages').on 'click', '.user-name', ->
    $('#shoutbox_message_message').val($('#shoutbox_message_message').val().replace(/^(@\w+: )?/, "@#{$.trim($(this).text())} ")).focus()