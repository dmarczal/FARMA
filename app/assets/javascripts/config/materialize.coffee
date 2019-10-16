$(document).on 'turbolinks:load', ->
  FARMA.reloadMaterilizeEffects()

FARMA.reloadMaterilizeEffects = ->
  Waves.displayEffect()            # reinitialize wave effect on button
  M.AutoInit()
  M.updateTextFields()

  if $('.materialize-textarea').lenght
    M.textareaAutoResize($('.materialize-textarea'))

  $('.dropdown-button').dropdown()
  $('input[autofocus]').siblings('label, i').addClass('active')
  $('.tooltipped').tooltip({delay: 200})
  $('.modal').modal()
  $('select').formSelect()
