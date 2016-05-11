# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

openMenu = () ->
  $('.btn-rotate').addClass('button-clicked').delay(100).queue(->
    $('.btn-rotate').attr('href', $('.button-clicked').attr('data-link'))
                        .attr('data-tooltip', 'Adicionar uma nova Introdução')
                        .dequeue()
    )

  $('.icon-rotate').delay(100).queue(->
      $(this).removeClass().addClass('mdi-content-create').addClass('icon-rotate').dequeue()
    )

  $('#menuBtn').css('display', 'block')

closeMenu = () ->
  $('.btn-rotate').removeClass('button-clicked').delay(100).queue(->
    $('.btn-rotate').attr('href',null)
                        .attr('data-tooltip', 'Editar o OA')
                        .dequeue()
  )

  $('.icon-rotate').delay(100).queue(->
      $(this).removeClass().addClass('mdi-action-list').addClass('icon-rotate').dequeue()
    )

  $('.fixed-action-btn').closeFAB();
  $('#menuBtn').css('display', 'none')

window.FARMA.menuBtn = ->

  $('.btn-rotate').click ->
    if $(this).hasClass 'button-clicked'
      closeMenu()
    else
      openMenu()

  $('#menuBtn').click ->
    closeMenu()
