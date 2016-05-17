$.fn.extend({
  openForm : ()->
    defaults = {
      millisecond : 100,
      type : "linear"
    }

    $('.fixed-modal-btn .modal').css({
                                    'overflow' : 'scroll',
                                    'margin' : '0',
                                    'padding' : '0'
                                    }).empty()

    $(this).animate({
        'bottom' : '100px',
        'right' : '1.7%'
      }, defaults.millisecond, defaults.type, null)
    $(this).animate({
        'bottom' : '200px',
        'right' : '3%'
      }, defaults.millisecond, defaults.type, null)
    $(this).animate({
        'bottom' : '400px',
        'right' : '5%'
      }, defaults.millisecond, defaults.type, null)
    $(this).animate({
        'botton' : '300px',
        'right' : '13%'
      }, defaults.millisecond, defaults.type, ()->
         $(this).addClass('btn-clicked')
         $('.fixed-modal-btn .modal').animate({
                'width' : '900px',
                'height' : '450px'
                'border-radius' : '30px';
           }, defaults.millisecond, defaults.type,
            $(this).animate({
                'bottom' : '50px'
              }, defaults.millisecond, defaults.type, ()->
                $('#box-form-question').fadeIn(1000)
              )
           )
      )

  closeForm : ()->
    defaults = {
      millisecond : 100,
      type : "linear"
    }

    $('.fixed-modal-btn .modal').css({
                                    'overflow' : 'hidden',
                                    'margin' : '0',
                                    'padding' : '0'
                                    }).empty()

    $('.fixed-modal-btn .modal').animate({
           'width' : '55.5px',
           'height' : '55.5px',
           'border-radius' : '50%'
      }, defaults.millisecond , defaults.type, null)

    $(this).animate({
        'bottom' : '400px',
        'right' : '5%'
      }, defaults.millisecond, defaults.type, null)

    $(this).animate({
        'bottom' : '200px',
        'right' : '3%'
      }, defaults.millisecond, defaults.type, null)

    $(this).animate({
        'bottom' : '100px',
        'right' : '1.7%'
      }, defaults.millisecond, defaults.type, ->
          $(this).removeClass('btn-clicked')
        )

    $(this).animate({
        'bottom' : '25px',
        'right' : '1.7%'
      }, defaults.millisecond, defaults.type, null)
})
