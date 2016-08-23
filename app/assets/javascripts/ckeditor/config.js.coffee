CKEDITOR.editorConfig = (config) ->
  # config:
  #   # language: 'pt-br'
  #   # toolbar: 'custom'
  #   extraPlugins: 'mathjax'
  #   # extraPlugins: 'tliyoutube,lineutils,widget,mathjax'
  #   scayt_autoStartup: true
  #   allowedContent: true
  #   mathJaxLib: '//cdn.mathjax.org/mathjax/2.2-latest/MathJax.js?config=TeX-AMS_HTML'
  #
  # # config.toolbar_mini = [
  # #   ["Bold",  "Italic",  "Underline",  "Strike",  "-",  "Subscript",  "Superscript"]
  # # ]

  config.language = 'pt-br'
  config.extraPlugins = 'lineutils,widget,mathjax'
  config.scayt_autoStartup = true
  config.allowedContent = true
  config.mathJaxLib = '//cdn.mathjax.org/mathjax/2.6-latest/MathJax.js?config=TeX-AMS_HTML'
  config.toolbar_custom = FARMA.CKEDITOR.toolbar.full
  config.toolbar = 'custom'
