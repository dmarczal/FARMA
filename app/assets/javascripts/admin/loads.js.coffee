$(document).ready ->
  window.FARMA.displayFlashMessages()

# https://github.com/mkhairi/materialize-sass/issues/63
# Fixed materialize because turbolinks
$(document).on 'turbolinks:load', ->
  window.FARMA.reloadMaterilizeEffects()


window.FARMA = {}

window.FARMA.reloadMaterilizeEffects = ->
  Waves.displayEffect() # reinitialize wave effect on button
  $('.dropdown-button').dropdown() # reinitialize dropdown
  # reinitialize form label
  Materialize.updateTextFields()

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
