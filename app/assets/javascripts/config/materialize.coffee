$(document).on 'turbolinks:load', ->
  FARMA.reloadMaterilizeEffects()

window.FARMA.reloadMaterilizeEffects = ->
  Waves.displayEffect()            # reinitialize wave effect on button
  $('.dropdown-button').dropdown() # reinitialize dropdown
  Materialize.updateTextFields()   # reinitialize form label
  #$('input[autofocus]').siblings('label, i').addClass('active')