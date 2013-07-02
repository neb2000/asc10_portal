$ ->
  $('#spotlight-box').on('show', ->
    setTimeout(->
      $('#spotlight-search').focus()
    , 0)
  )
  
  $('#spotlight-search').click (e)->
    e.stopPropagation()
    
  $('#spotlight-search').keyup ->
    return unless $(this).val() is '' or $(this).val().length > 2
    $(this).data('old-value', '') unless $(this).data('old-value')?
    
    if $(this).data('old-value') isnt $(this).val()
      clearTimeout($(this).data('timeout'))
      $(this).data('timeout', setTimeout("$('#spotlight-search').trigger('submit-form')", 200))
    
  $('#spotlight-search').on('submit-form', ->
    $(this).data('old-value', $(this).val())
    $('#spotlight-form').submit()
  )
  
  $('#spotlight-form').submit ->
    $(this).prepend('<div id="search-spinner"><i class="icon-spinner icon-spin"></i></div>')