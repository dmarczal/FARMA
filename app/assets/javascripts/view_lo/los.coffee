window.FARMA.updateBars = (process_bar, preview_bar) ->
  percent_process_bar = $(".bar").width() * process_bar / 100
  percent_preview_bar = $(".bar").width() * preview_bar / 100

  $(".process-bar").css "width", percent_process_bar
  $(".preview-bar").css "width", percent_preview_bar

  $("#process-bars .preview-bar-percent .percent").html preview_bar
  $("#process-bars .process-bar-percent .percent").html process_bar
  $("#process-bars .not-preview-bar-percent .percent").html 100 - preview_bar
