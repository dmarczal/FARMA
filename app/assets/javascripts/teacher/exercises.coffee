# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.FARMA.slideQuestion = (button_clicked)->
  console.log button_clicked
  div_id = '#' + $(button_clicked).attr('data-target')
  $(button_clicked).toggleClass 'active'
  $(div_id).slideToggle()
  window.FARMA.Keyboard.preLoad($(button_clicked).attr('data-id'))

window.FARMA.toggleNewQuestion = ->
  $('#box-new-question').slideToggle(1000)
  $('.fixed-modal-btn').fadeToggle(1000)

window.FARMA.modalOpen = ->
  $('.fixed-modal-btn').click ->
    window.FARMA.toggleNewQuestion()

  $('#content-teacher').on 'click', '.cancel-new-question',->
    window.FARMA.toggleNewQuestion()

window.FARMA.showQuestion = ->
  $('#questions_list').on 'click', '.show-question', ->
    window.FARMA.slideQuestion this;

window.FARMA.requestEditQuestion = ->
  $('#content-teacher').on 'click', '.ajax-question-box .btn-cancel-question', ->
    window.FARMA.slideQuestion '#show-question-' + $(this).attr('data-id')

  $('#content-teacher').on 'click', '.edit-question', ->
    window.FARMA.slideQuestion '#show-question-' + $(this).attr('data-id')

window.FARMA.requestFormTip = ->
  $('#content-teacher').on 'click', '.new-tip-btn', ->
    window.FARMA.toggleBoxNewTip '#box-new-tips-for-' + $(this).attr('data-id')

  $('#content-teacher').on 'click', '.close-tip', ->
    window.FARMA.toggleBoxNewTip '#box-new-tips-for-' + $(this).attr('data-id')

window.FARMA.toggleBoxNewTip = (box_new_tip) ->
  $(box_new_tip).slideToggle()
