# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.FARMA.hideList = ->
  $('#nav-oas > li').click ->
    $('#OAs > ul').removeClass 'list-active'
    $($(this).attr("data-ul")).addClass 'list-active'
