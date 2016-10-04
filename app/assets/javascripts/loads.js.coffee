$(document).ready ->
  window.FARMA.displayFlashMessages()
  window.FARMA.loadMouseOverOnCard()
  window.FARMA.researchIcon()
  window.FARMA.sidebarScrollSpy()
  window.FARMA.tabbedResearchs()

# https://github.com/mkhairi/materialize-sass/issues/63
# Fixed materialize because turbolinks
$(document).on 'page:change', ->
  window.FARMA.reloadMaterilizeEffects()
  window.FARMA.navBarFixed()

$(document).on 'page:update', ->
  MathJax.Hub.Queue(["Typeset",MathJax.Hub]);

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
