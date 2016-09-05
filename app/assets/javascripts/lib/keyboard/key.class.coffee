class window.FARMA.Key
  construct: (e) ->
    @hotKeyParams e

  hotKeyParams: (e) ->
    # $(document).on 'keydown', null, 'shift+g', ->
    #   console.log "alt r worked"
    #   addToJax("\\sqrt")
    #   true
    switch e.key
      when 's' then window.FARMA.Screen.addToJax("\\sqrt")
      when 'o' then window.FARMA.Screen.addToJax("\\over")
      else window.FARMA.Screen.addToJax(e.key)
