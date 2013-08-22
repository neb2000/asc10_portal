$ ->
  $(document).one('page:fetch', ->
    NProgress.start()
  ).one('page:load', ->
    NProgress.done()
  )