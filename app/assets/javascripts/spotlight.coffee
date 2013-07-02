$ ->
  $('#spotlight-box').on('show', ->
    setTimeout(->
      $('#spotlight-search').focus()
    , 0)
  )
  
  $('#spotlight-search').click (e)->
    e.stopPropagation()
    
  $('#spotlight-search').keyup ->
    return unless $(this).val().length > 2
    unless $(this).data('old-value')? and $(this).data('old-value') is $(this).val()
      clearTimeout($(this).data('timeout'))
      $(this).data('timeout', setTimeout("$('#spotlight-form').submit()", 200))
    $(this).data('old-data', $(this).val())
  
  $('#spotlight-form').submit ->
    $(this).prepend('<div id="search-spinner"><i class="icon-spinner icon-spin"></i></div>')