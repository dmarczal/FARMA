# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.FARMA.toggleBoxNewTips = ->
  $(document).on 'click', '.btn-new-tip', ->
    new_tip = $('#' + $(this).attr('data-target'))
    new_tip.addClass 'open-box-tip'

  $(document).on 'click', '.cancel-tip', ->
    new_tip = $('#' + $(this).attr('data-target'))
    new_tip.addClass('close-box-tip').delay(3000).queue(->
      $(this).removeClass('open-box-tip').dequeue()
      ).delay().queue ->
        $(this).removeClass('close-box-tip').dequeue()
