ready = ->
  $(".show-photo").change ->
    $.ajax
      type: "POST"
      url: "/admin/photos/" + this.value + "/update_show"
      dataType: "json"
      success: (data) ->

      error: ->
    return


$(document).ready(ready)
$(document).on('page:load', ready)
