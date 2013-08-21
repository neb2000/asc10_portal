$ ->
  $(document).one('page:fetch', ->
    NProgress.start()
  ).one('page:receive', ->
    NProgress.done()
  )