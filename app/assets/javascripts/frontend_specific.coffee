$.fn.wysihtml5.defaultOptions.size = 'inverse'
wowhead_tooltips =
  colorlinks: true
  iconizelinks: true
  renamelinks: true
$ -> 
  $('#menu').affix(
    offset: {
      top: ->
        Math.ceil($('#banner').height())
    }
  )
  if $('.sidebar').size() > 0
    $('#main-content').css('min-height', $('#content').height())
    
  $('table.table-responsive thead th').each (index) ->
    label = if $(this).data('label')? then $(this).data('label') else $(this).text()
    $("tr td:nth-child(#{index + 1})", $(this).closest('thead').next('tbody')).attr('data-label', label)