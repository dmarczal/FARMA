$(document).on 'turbolinks:load', ->
  FARMA.reloadMaterilizeEffects()

FARMA.reloadMaterilizeEffects = ->
  Waves.displayEffect()            # reinitialize wave effect on button
  $('.dropdown-button').dropdown() # reinitialize dropdown
  Materialize.updateTextFields()   # reinitialize form label
  $('input[autofocus]').siblings('label, i').addClass('active')
  $('.tooltipped').tooltip({delay: 200})
  $('.button-collapse').sideNav() # reinitialize nav-mobile
  # $('.modal-trigger').modal()
  $('.modal').modal()
  $('select').material_select()
