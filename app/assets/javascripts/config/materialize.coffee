$(document).on 'turbolinks:load', ->
  FARMA.reloadMaterilizeEffects()

FARMA.reloadMaterilizeEffects = ->
  Waves.displayEffect()            # reinitialize wave effect on button
  $('.dropdown-button').dropdown() # reinitialize dropdown
  Materialize.updateTextFields()   # reinitialize form label
