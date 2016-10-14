FARMA.CKEDITOR =
  clear: ->
    $.each CKEDITOR.instances, (i, editor) ->
      try
        editor.destroy()
      catch error
        console.log error

  clearWhoHas: (key) ->
    $.each CKEDITOR.instances, (i, editor) ->
      try
        if editor.name.search(key) != -1
          editor.destroy()
      catch error
        #console.log error

  destroy: (key) ->
    @.clearWhoHas key

  show: (el, config) ->
    el = '#ckeditor' unless el
    unless config
      config =
        language: 'pt-br',
        toolbar: FARMA.CKEDITOR.toolbar.full
        extraPlugins: 'tliyoutube,lineutils,widget,mathjax'
        scayt_autoStartup: true
        allowedContent: true
        mathJaxLib: '//cdn.mathjax.org/mathjax/2.2-latest/MathJax.js?config=TeX-AMS_HTML'

    setTimeout ( ->
      $(el).ckeditor(config)
    ), 100

  toolbar:
    basic:
      [
        { name: 'document', items : [ 'Source','-', 'NewPage','Preview' ] },
          { name: 'basicstyles', items : [ 'Bold','Italic' ] },
          { name: 'styles',  items : [ 'Styles','Format','Font','FontSize' ] }
          { name: 'paragraph', items : [ 'NumberedList','BulletedList', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock', '-', 'Underline','Strike','Subscript','Superscript' ] },
          { name: 'links',  items : [ 'Link','Unlink','Anchor' ] },
          { name: 'tools', items : [ 'Maximize','-','About' ] },
          { name: 'insert', items : [ 'Image', 'Mathjax', 'Table','HorizontalRule'] },
          { name: 'colors', items : [ 'TextColor','BGColor' ] }
      ]
    full:
      [
        { name: 'document',    items : [ 'Source','-','NewPage','DocProps','Preview','Print','-','Templates' ] },
        { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
        { name: 'editing',     items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
        { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
        { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
        { name: 'links',       items : [ 'Link','Unlink','Anchor' ] },
        { name: 'insert',      items : [ 'Image', 'Mathjax', 'Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak', 'Frame' ] },
        '/',
        { name: 'styles',      items : [ 'Styles','Format','Font','FontSize' ] },
        { name: 'colors',      items : [ 'TextColor','BGColor' ] },
        { name: 'tools',       items : [ 'Maximize', 'ShowBlocks','-','About' ] },
        { name: 'Video',       items : [ 'tliyoutube'] }
      ]
