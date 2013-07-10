window.requestAnimFrame = (->
  window.requestAnimationFrame or window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or window.oRequestAnimationFrame or window.msRequestAnimationFrame or (callback) ->
    window.setTimeout callback, 1000 / 60
)()
Stroll = bind: (element) ->
  items = Array::slice.apply(element.children)
  # caching some heights so we don't need to go back to the DOM so much
  listHeight = element.offsetHeight
  # one loop to get the offsets from the DOM
  i = 0
  len = items.length
  while i < len
    items[i]._offsetTop = items[i].offsetTop
    items[i]._offsetHeight = items[i].offsetHeight
    i++
  (->
    # Apply past/future classes to list items outside of the viewport
    update = ->
      scrollTop = element.pageYOffset or element.scrollTop
      scrollBottom = scrollTop + listHeight
      
      # Quit if nothing changed.
      return  if scrollTop is element.lastTop
      element.lastTop = scrollTop
      
      # One loop to make our changes to the DOM
      i = 0
      len = items.length

      while i < len
        item = items[i]
        
        # Above list viewport
        if item._offsetTop + item._offsetHeight < scrollTop
          item.classList.add "past"
        
        # Below list viewport
        else if item._offsetTop > scrollBottom
          item.classList.add "future"
        
        # Inside of list viewport
        else
          item.classList.remove "past"
          item.classList.remove "future"
        i++
    (animloop = ->
      requestAnimFrame animloop
      update()
    )()
  )()
$ ->
  $('#existing-messages').on('init-animation', ->
    Stroll.bind(this)
  )
  
  $('#existing-messages').trigger('init-animation')