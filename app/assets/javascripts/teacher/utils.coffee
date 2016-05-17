# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.FARMA.toggleVerticalMenu = ->
  $('#button-painel').click ->
    $('#painel').toggleClass 'active'

    if $('#painel').hasClass 'active'
      $('#content-teacher').removeClass('l12').addClass('l9')
    else
      $('#content-teacher').removeClass('l9').addClass('l12')
