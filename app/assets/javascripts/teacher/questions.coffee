# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.FARMA.modalOpen = ->
  $('.fixed-modal-btn').click ->
    unless $(this).hasClass 'btn-clicked'
      $(this).openForm()

  $(document).on 'click', '#cancel', ()->
    $('.fixed-modal-btn').closeForm()


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
        'top' : '50%',
        'right' : '1%'
      }, defaults.millisecond, defaults.type, null)
    $(this).animate({
        'top' : '60%',
        'right' : '3%'
      }, defaults.millisecond, defaults.type, null)
    $(this).animate({
        'top' : '70%',
        'right' : '6.5%'
      }, defaults.millisecond, defaults.type, null)
    $(this).animate({
        'top' : '66%',
        'right' : '10%'
      }, defaults.millisecond, defaults.type, ()->
         $(this).addClass('btn-clicked')
         $('.fixed-modal-btn .modal').animate({
                'width' : '900px',
                'height' : '450px'
                'border-radius' : '30px';
           }, defaults.millisecond, defaults.type,
            $(this).animate({
                'top' : '25%'
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
        'top' : '66%',
        'right' : '10%'
      }, defaults.millisecond, defaults.type, null)

    $(this).animate({
        'top' : '70%',
        'right' : '6.5%'
      }, defaults.millisecond, defaults.type, null)

    $(this).animate({
        'top' : '60%',
        'right' : '3%'
      }, defaults.millisecond, defaults.type, null)

    $(this).animate({
        'top' : '50%',
        'right' : '1%'
      }, defaults.millisecond, defaults.type, ->
          $(this).removeClass('btn-clicked')
        )

    $(this).animate({
        'top': '100px',
        'right': '2%'
      }, defaults.millisecond, defaults.type, null)
})
