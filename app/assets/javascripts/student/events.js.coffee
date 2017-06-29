$(document).on 'turbolinks:load', ->
  FARMA.barsUpdate()

FARMA.barsUpdate = ->
  if $('div.bar').length > 0
    FARMA.setbars()

FARMA.setbars = ->
  width = $('.bar').width()
  progressPersent = parseInt($('.progress-bar').data('percent'))
  viewPersent = parseInt($('.view-bar').data('percent'))

  progressWidth = width * progressPersent/100
  viewWidth = width * viewPersent/100

  $('.progress-bar').width(progressWidth)
  $('.view-bar').width(viewWidth)
