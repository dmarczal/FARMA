# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  FARMA.navBarFixed()
  FARMA.loadMouseOverOnCard()
  FARMA.researchIcon()
  FARMA.sidebarScrollSpy()
  FARMA.tabbedResearchs()

FARMA.reloadMaterilizeEffects = ->
  Waves.displayEffect() # reinitialize wave effect on button
  $('.dropdown-button').dropdown() # reinitialize dropdown
  # Materialize.updateTextFields() # reinitialize form label
  $('input[autofocus]').siblings('label, i').addClass('active')
  $('.button-collapse').sideNav() # reinitialize nav-mobile
  $('.parallax').parallax() # reinitialize parallax
  $('.slider').slider()

FARMA.navBarFixed = ->
  $(window).scroll ->
    if $(this).scrollTop() > 0
      $('img.logo').addClass 'nav-bar-fixed'
      $('#home-page-navba').addClass 'active'
    else
      $('img.logo').removeClass 'nav-bar-fixed'
      $('#home-page-navbar').removeClass 'active'

FARMA.loadMouseOverOnCard = ->
  FARMA.mouseOverOnCard("#home-page-team .card")

FARMA.researchIcon = ->
  $('#home-page-researchs .collapsible-header').click (e)->
    $('#home-page-researchs .icon-arrow i').html('keyboard_arrow_down')

    unless ($(@).hasClass('active'))
      $(@).find('i').html('keyboard_arrow_up')

FARMA.sidebarScrollSpy = ->
  $('.scrollspy').scrollSpy({scrollOffset: 63})
  $('.tooltipped').tooltip({delay: 20})

FARMA.tabbedResearchs = ->
  $('ul.tabs').tabs();
  $('.show-less').hide()
  $('.show-more').on 'click', ->
    $('.more').show()
    Materialize.showStaggeredList('.more')
    $('.show-more').hide()
    $('.show-less').show()
  $('.show-less').on 'click', ->
    $('.more').hide()
    $('.more').children().css('opacity', 0)
    $('.show-less').hide()
    $('.show-more').show()
