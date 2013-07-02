$ ->
  $(document).one('page:fetch', ->
    $('#wrapper').prepend($('<div id="page-load-spinner"><i class="icon-spinner icon-spin"></i> Loading...</div>'))
  ).one('page:receive', ->
    $('#page-load-spinner').remove()
  )