$ ->
  $(window).on 'position-changed', ->
    url = $('.endless-page .pagination .next_page a').attr('href')
    if url && url isnt '#' && $(window).scrollTop() > $(document).height() - $(window).height() - 50
      $('.pagination').text('Loading...')
      $.getScript(url)
  $(window).scroll ->
    $(this).trigger('position-changed')