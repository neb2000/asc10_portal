$.fn.wysihtml5.defaultOptions.size = 'inverse'
$ -> 
  $('#menu').affix(
    offset: {
      top: ->
        Math.ceil($('#banner').height())
    }
  )
  if $('.sidebar').size() > 0
    $('#main-content').css('min-height', $('#content').height())