# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.FARMA.toggleBoxRequestQuestions = ->
  $(document).on 'click', '.ajax-question-box .btn-cancel', ->
    div_id = '#' + $(this).attr('data-target')
    $(div_id).slideUp()
