$ ->
  $('[data-typeahead-url]').each ->
    $this = $(this)
    $(this).typeahead(
      source: (query, process) ->
        $.get($this.data('typeahead-url'), { query: query }, (data) ->
          process data
        , 'json')
    )