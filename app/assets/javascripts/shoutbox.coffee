$ ->
  $('[data-content-url]').each ->
    $.getScript $(this).data('content-url'), ->
      $('#main-content').css('min-height', $('#content').height())
  
  $('#existing-messages').on 'click', '.user-name', ->
    $('#shoutbox_message_message').val($('#shoutbox_message_message').val().replace(/^(@\w+: )?/, "@#{$.trim($(this).text())} ")).focus()