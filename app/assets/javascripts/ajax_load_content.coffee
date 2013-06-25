$ ->
  $('[data-load-content-url]').each ->
    $.getScript($(this).data('load-content-url'))