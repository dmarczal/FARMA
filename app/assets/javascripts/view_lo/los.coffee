window.FARMA.updateBars = (process_bar, preview_bar) ->
  percent_process_bar = 200 * process_bar / 100
  percent_preview_bar = 200 * preview_bar / 100

  $(".process-bar").css "width", percent_process_bar
  $(".preview-bar").css "width" : percent_preview_bar
