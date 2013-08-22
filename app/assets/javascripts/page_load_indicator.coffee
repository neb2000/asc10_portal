document.addEventListener("page:fetch", ->
  NProgress.start()
)

document.addEventListener("page:load", ->
  NProgress.done()
)

document.addEventListener("page:restore", ->
  NProgress.remove()
)