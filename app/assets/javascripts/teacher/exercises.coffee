# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.FARMA.showQuestion = ->
  $('#questions_list').on 'click', '.show-question', ->
    div_id = '#' + $(this).attr('data-target')
    $(this).toggleClass 'active'
    $(div_id).slideToggle()
