# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.FARMA.toggleVerticalMenu = ->
  $('#button-painel').click ->
    if $('#painel').hasClass 'active'
      $('#painel').removeClass 'active'
      $('#content-teacher').removeClass()
      $('#content-teacher').addClass 'col s12 row'
      # $('#main-teacher').addClass 'container'
    else
      $('#painel').addClass 'active'
      $('#content-teacher').removeClass()
      $('#content-teacher').addClass 'col s9 row'
      # $('#main-teacher').removeClass 'container'
