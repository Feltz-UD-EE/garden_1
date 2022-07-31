$ ->
  $("input.datepicker_field").each (i) ->
    $(this).datepicker
      dateFormat: "mm/dd/yy"
      changeMonth: true
      changeYear: true
      yearRange: "-140:+2"
    .on "keyup", ->
      try
        date = $.datepicker.parseDate($.datepicker._defaults.dateFormat, this.value )
      catch
        if (!date)
          $(this).next().val("")

  $("input.datepicker-future").each (i) ->
    $mindate = new Date
    $(this).datepicker
      dateFormat: "mm/dd/yy"
      changeMonth: true
      changeYear: true
      yearRange: "-0:+10"
      minDate: $mindate
      beforeShowDay: (date) ->
        if (date < new Date())
          return {0: false}
        else
          return {0: true}
    .on "keyup", ->
      try
        date = $.datepicker.parseDate($.datepicker._defaults.dateFormat, this.value )
      catch
        if (!date)
          $(this).next().val("")
