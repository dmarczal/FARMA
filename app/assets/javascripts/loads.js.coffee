activePainel = ->
  $('#button-user').click ->
    if $(this).hasClass 'active_painel'
      $(this).removeClass 'active_painel'
      $('#slide-out').removeClass 'hide'
      $('#icon_button').removeClass 'active_painel'
    else
      $(this).addClass 'active_painel'
      $('#icon_button').addClass 'active_painel'
      $('#slide-out').addClass 'hide'

$(document).ready ->
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

# https://github.com/mkhairi/materialize-sass/issues/63
# Fixed materialize because turbolinks
$(document).on 'page:change', ->
  Materialize.updateTextFields()  # reinitialize form label
  Waves.displayEffect() # reinitialize wave effect on button
  $('.dropdown-button').dropdown() # reinitialize dropdown
  $('.button-collapse').sideNav() #reinitialize nav-mobile
  $('.parallax').parallax() #reinitialize parallax
  activePainel()
