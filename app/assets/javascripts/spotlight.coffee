$ ->
  $('#spotlight-box').on('show', ->
    setTimeout(->
      $('#spotlight-search').focus()
    , 0)
  )
  
  $('#spotlight-search').click (e)->
    e.stopPropagation()