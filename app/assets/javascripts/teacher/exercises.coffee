# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.FARMA.slideQuestion = (button_clicked)->
  div_id = '#' + $(button_clicked).attr('data-target')
  $(button_clicked).toggleClass 'active'
  $(div_id).slideToggle()

window.FARMA.showQuestion = ->
  $('#questions_list').on 'click', '.show-question', ->
    window.FARMA.slideQuestion this;

window.FARMA.modalOpen = ->
  $('.fixed-modal-btn').click ->
    $(this).fadeOut()
    $('#box-new-question').css 'height', '850px'
    $('#box-new-question').slideDown(2000)

window.FARMA.toggleBoxRequestQuestions = ->
  $('#content-teacher').on 'click', '.ajax-question-box .btn-cancel-question', ->
    window.FARMA.slideQuestion '#show-question-' + $(this).attr('data-id')

  $('#content-teacher').on 'click', '.edit-question', ->
    window.FARMA.slideQuestion '#show-question-' + $(this).attr('data-id')
