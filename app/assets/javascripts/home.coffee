# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.FARMA.navBarFixed = ->
  $(window).scroll ->
    if $(this).scrollTop() > 0
      $('img.logo').addClass 'nav-bar-fixed'
    else
      $('img.logo').removeClass 'nav-bar-fixed'


window.FARMA.researchIcon = ->
  $('#home-page-researchs .collapsible-header').click (e)->
    $('#home-page-researchs .icon-arrow i').html('keyboard_arrow_down')

    unless ($(@).hasClass('active'))
      $(@).find('i').html('keyboard_arrow_up')
