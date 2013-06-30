$ ->
  $('[data-stream-url]').each ->
    $(this).data('faye-client', new Faye.Client($(this).data('stream-url'))) unless $(this).data('faye-client')?
  
  if $('#existing-messages').size() > 0
    $('body').data('faye-client').subscribe('/asc10/messages', (data) ->
      eval(data)
    )