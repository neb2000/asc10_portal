$ ->
  $('[data-stream-url]').each ->
    unless $(this).data('faye-client')?
      client = new Faye.Client($(this).data('stream-url'))
      client.bind('transport:down', ->
        $('.faye-warning-box').html('Connection lost, please refresh the page')
      )
      client.bind('transport:up', ->
        $('.faye-warning-box').html('')
      )
      $(this).data('faye-client', client)
  
  if $('#existing-messages').size() > 0
    $('body').data('faye-client').subscribe('/asc10/messages', (data) ->
      eval(data)
    )