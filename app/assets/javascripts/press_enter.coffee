$.fn.pressEnter = (fn) ->
  @each ->
    $(this).bind "enterPress", fn
    $(this).keyup (e) ->
      $(this).trigger "enterPress"  if e.keyCode is 13
      return
    return