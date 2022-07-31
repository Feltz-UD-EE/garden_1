$(window).bind("load", () ->
    footer = $("#copyright")
    pos = footer.position()
    height = $(window).height()
    height = height - pos.top
    height = height - footer.height()
    if height > 0
        footer.css({
            'margin-top': (height - 20) + 'px'
        })
)

if $('.is-patient').val() == 'false'
    $('#navbar').css('max-width', '1600px')
    $('.content-row').css('max-width', '1600px')

$('.home').show()