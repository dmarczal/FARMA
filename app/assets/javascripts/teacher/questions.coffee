# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.FARMA.modalOpen = ->
  $('.fixed-modal-btn').click ->
    unless $(this).hasClass 'btn-clicked'
      $(this).openForm()

  $("#content-teacher").on 'click', '.fixed-modal-btn .btn-cancel', () ->
    $('.fixed-modal-btn').closeForm()
