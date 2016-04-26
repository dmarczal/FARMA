# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.FARMA.modalOpen = ->
  $(document).on 'click', '.btn-open-modal', ->
    modal_tag = $('.modal')
    modal_tag.attr("data-target", $(this).attr('id'))
    positions = $(this).offset()

    modal_tag.css({
      'left' : (positions.left + $(this).width()/2) + 'px',
      'top': (positions.top + ($(this).height()/2) - $(window).scrollTop()) + 'px'
    })

    modal_tag.css("display","block")
    modal_tag.animate({
        'left' : '0',
        'top' : '0',
        'width' : '100%',
        'height' : '100%'
      }, 800, null, ()->
        modal_tag.addClass('modal-open')
      )

  $('.modal').on 'click', (event) ->
    button = $('#'+$(this).attr("data-target"))
    positions = button.offset()
    width = $('.modal-box').width()
    height = $('.modal-box').height()
    margin_left = parseInt($('.modal-box').css('margin-left').replace("px", ""));
    margin_top = parseInt($('.modal-box').css('margin-top').replace("px", ""));
    mouse_in_modal_box = (event.pageX - margin_left) > 0 && (event.pageX - margin_left) < width
    mouse_in_modal_box &= (event.pageY - margin_top) > 0 && (event.pageY - margin_top) < height

    if(!mouse_in_modal_box)
      $('.modal').removeClass('modal-open'  )

      $('.modal').animate({
          'left' : (positions.left + $(button).width()/2) + 'px',
          'top' : (positions.top + ($(button).height()/2) - $(window).scrollTop()) + 'px',
          'width' : '5px',
          'height' : '5px'
        }, 500, null, ()->
          $('.modal').css("display","none")
        )
