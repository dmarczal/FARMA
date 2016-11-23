window.FARMA.updateBars = (percent_process_bar, percent_preview_bar) ->
  width_process_bar = $(".bar").width() * percent_process_bar / 100
  width_preview_bar = $(".bar").width() * percent_preview_bar / 100

  $(".process-bar").css "width", width_process_bar
  $(".preview-bar").css "width", width_preview_bar

  $("#process .preview-bar-percent .percent").html percent_preview_bar
  $("#process .process-bar-percent .percent").html percent_process_bar
  $("#process .not-preview-bar-percent .percent").html 100 - percent_preview_bar
