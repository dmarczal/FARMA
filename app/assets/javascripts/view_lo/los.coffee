window.FARMA.updateBars = (percent_process_bar, percent_preview_bar) ->
  width_process_bar = $(".bar").width() * percent_process_bar / 100
  width_preview_bar = $(".bar").width() * percent_preview_bar / 100

  $(".process-bar").css "width", width_process_bar
  $(".preview-bar").css "width", width_preview_bar

  $("#process .preview-bar-percent .percent").html percent_preview_bar
  $("#process .process-bar-percent .percent").html percent_process_bar
  $("#process .not-preview-bar-percent .percent").html 100 - percent_preview_bar

window.FARMA.navBarFixed = ->
  $(window).scroll ->
    if $(this).scrollTop() > 0
      $('nav').addClass 'active'
      $('#lo-panel').addClass 'active'
    else
      $('nav').removeClass 'active'
      $('#lo-panel').removeClass 'active'

window.FARMA.showKeyboard = ->
  $(".box-response").on 'click', ->
      window.FARMA.Keyboard.preLoad($(@).attr('data-id'))
