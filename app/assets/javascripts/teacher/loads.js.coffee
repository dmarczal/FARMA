$(document).ready ->
  window.FARMA.displayFlashMessages()

# https://github.com/mkhairi/materialize-sass/issues/63
# Fixed materialize because turbolinks
$(document).on 'page:change', ->
  window.FARMA.reloadMaterilizeEffects()
  window.FARMA.toggleVerticalMenu()
  window.FARMA.modalOpen()
  window.FARMA.toggleBoxRequestQuestions()
  window.FARMA.showQuestion()
  window.FARMA.fixTooltip()
  window.FARMA.imagePreview()

window.FARMA = {}

window.FARMA.reloadMaterilizeEffects = ->
  Waves.displayEffect() # reinitialize wave effect on button
  $('.dropdown-button').dropdown() # reinitialize dropdown
  # reinitialize form label
  Materialize.updateTextFields()
  $('input[autofocus]').siblings('label, i').addClass('active')
  $('.tooltipped').tooltip({delay: 200})
  $('.button-collapse').sideNav() # reinitialize nav-mobile
  $('.modal-trigger').leanModal()

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
