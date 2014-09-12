ready = ->
  $(".show-photo").change ->
    console.log "hello"
    return


$(document).ready(ready)
$(document).on('page:load', ready)
