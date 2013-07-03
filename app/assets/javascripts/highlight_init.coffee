$ ->
  $('[data-highlight]').each ->
    $(this).highlight($(this).data('highlight').split(/\s+/))