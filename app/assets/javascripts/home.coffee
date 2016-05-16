# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.FARMA.navBarFixed = ->
  $(window).scroll ->
    if $(this).scrollTop() > 0
      $('.logo').addClass 'nav-bar-fixed'
    else
      $('.logo').removeClass 'nav-bar-fixed'
