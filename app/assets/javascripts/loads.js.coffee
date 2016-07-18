$(document).ready ->
  window.FARMA.displayFlashMessages()
  window.FARMA.loadMouseOverOnCard()

# https://github.com/mkhairi/materialize-sass/issues/63
# Fixed materialize because turbolinks
$(document).on 'page:change', ->
  window.FARMA.reloadMaterilizeEffects()
  window.FARMA.navBarFixed()


window.FARMA = {}

window.FARMA.reloadMaterilizeEffects = ->
  Waves.displayEffect() # reinitialize wave effect on button
  $('.dropdown-button').dropdown() # reinitialize dropdown
  Materialize.updateTextFields() # reinitialize form label
  $('input[autofocus]').siblings('label, i').addClass('active')
  $('.button-collapse').sideNav() # reinitialize nav-mobile
  $('.parallax').parallax() # reinitialize parallax
  $('.slider').slider()


window.FARMA.displayFlashMessages = ->
  toastr.options =
    "closeButton": false,
    "debug": false,
    "positionClass": "toast-bottom-right",
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"

window.FARMA.loadMouseOverOnCard = ->
  $(".card").mouseenter (e) ->
    if $(@).find('> .card-reveal').length
      if $(e.target).is($('.card .activator')) || $(e.target).is($('.card .activator i'))
        # Make Reveal animate up
        car_reveal = $(@).find('.card-reveal')
        car_reveal.css({ display: 'block'})
        car_reveal.velocity("stop", false)
        car_reveal.velocity({translateY: '-100%'},
                            {duration: 300, queue: false, easing: 'easeInOutQuad'})

      $('.card-reveal').closest('.card').css('overflow', 'hidden');

  $(".card").mouseleave ->
    # Make Reveal animate down and display none
    $(@).find('.card-reveal').velocity {translateY: 0},
       duration: 225,
       queue: false,
       easing: 'easeInOutQuad',
       complete: ->
          $(this).css({ display: 'none'})
