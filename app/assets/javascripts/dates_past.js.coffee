$ ->
  $("input.datepicker_past").each (i) ->
    $mindate = $('#reg_date').val()
    $(this).datepicker
      dateFormat: "mm/dd/yy"
      changeMonth: true
      changeYear: true
      yearRange: "-1:+0"
      minDate: $mindate
      maxDate: "+0"
      beforeShowDay: (date) ->
        if (date > new Date())
          return {0: false}
        else
          return {0: true}
    .on "keyup", ->
      try
        date = $.datepicker.parseDate($.datepicker._defaults.dateFormat, this.value )
      catch
        if (!date)
          $(this).next().val("")

  $("input.datepicker_longpast").each (i) ->
    $mindate = $('#reg_date').val()
    $(this).datepicker
      dateFormat: "mm/dd/yy"
      changeMonth: true
      changeYear: true
      yearRange: "-140:+0"
      minDate: $mindate
      maxDate: "+0"
      beforeShowDay: (date) ->
        if (date > new Date())
          return {0: false}
        else
          return {0: true}
    .on "keyup", ->
      try
        date = $.datepicker.parseDate($.datepicker._defaults.dateFormat, this.value )
      catch
        if (!date)
          $(this).next().val("")
