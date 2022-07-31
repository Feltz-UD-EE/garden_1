$ ->
  $("input.datetimepicker").each (i) ->
    $(this).datetimepicker
      altFormat: "yy-mm-dd"
      altTimeFormat: "HH:mm"
      altSeparator: " "
      altFieldTimeOnly: false
      dateFormat: "mm/dd/yy"
      timeFormat: 'hh:mm TT'
      hourGrid: 4
      minuteGrid: 10
      changeMonth: true
      changeYear: true
      yearRange: "-2:+2"
      altField: $(this).next()
    .on "keyup", ->
      try
        date = $.datepicker.parseDate($.datepicker._defaults.dateFormat, this.value )
      catch
        if (!date)
          $(this).next().val("")
