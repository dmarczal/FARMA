class window.FARMA.Screen

  decimalAdded: false
  equation: 0
  matrix: 0
  cursorIndex: 0

  @construct: () ->
    # console.log "ok"
    # $('#keyboard').append('<div class="jax" id="MathOutput">$${}$$</div>')
    # #<!-- Screen and clear key -->
    # $('#keyboard').append('<div class="top"></div>')
    # $('.top').append('<span class="clear" value="C">C</span>')
    # $('.top').append('<input type="hidden" class="screen" id="MathInput"></input>')
    # $('.top').append('<span class="clear" value="<"><-</span>')
    # $('.top').append('<span class="clear" value=">">-></span>')

  @addToJax: (what) ->
    # Add new value to the end of screen output
    actual = $(".screen").val()
    update = actual + what
    console.log actual + " <- " + what + " becomes " + update
    findBrackets = ///\}$///
    findMatrix = ///\{matrix\}///

    if actual.match findBrackets
      console.log "brackets found!"
      update = actual.replace "}", what + "}"
    else
      console.log "no brackets!"

    if actual.match findMatrix
      console.log "working in matrix"
      console.log actual.split("\\end{matrix}").join("#{what}\\end{matrix}")
      update = actual.split("\\end{matrix}").join("#{what}\\end{matrix}")

    $(".screen").val(update)

    # Render new TeX
    MathJax.Hub.Queue(["Typeset", MathJax.Hub])
    tex = MathJax.Hub.getAllJax('MathOutput')[0]
    MathJax.Hub.queue.Push [
      'Text'
      tex
      '\\displaystyle{' + update + '}'
    ]

  @cleanScreen: () ->
    # Remove all screen values
    $(".screen").val("")
    console.log "empty screen"

    # Reset TeX Hub
    MathJax.Hub.Queue(["Typeset", MathJax.Hub])
    tex = MathJax.Hub.getAllJax('MathOutput')[0]
    MathJax.Hub.queue.Push [
      'Text'
      tex
      ''
    ]
