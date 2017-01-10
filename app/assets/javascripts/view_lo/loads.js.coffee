$(document).ready ->
  window.FARMA.displayFlashMessages()
  # window.FARMA.keyboardPanel()

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
  Materialize.updateTextFields() # reinitialize form label
  $('.dropdown-button').dropdown()

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

# window.FARMA.keyboardPanel = ->
#   $(document).on 'click', '.box-response', ->
#     id = $(@).data('id')
#     new window.FARMA.Keyboard(id)
#     $(@).hide()

# window.FARMA.keyboardPanel = (div_id) ->
#   $(document).on 'click', div_id + ' .box-response', ->
#     id = div_id.substring(10, 12).replace("-", "")
#     $('.box-response').hide()
#     new window.FARMA.Keyboard(id)
#     $(div_id + ' .box-response').hide()
