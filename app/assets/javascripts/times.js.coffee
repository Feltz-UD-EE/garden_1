$ -> 
  $("input.timepicker").each (i) ->
    $(this).timepicker
      timeFormat: ' h:mm TT'
      hourGrid: 4
      minuteGrid: 10