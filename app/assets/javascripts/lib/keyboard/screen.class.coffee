class window.FARMA.Screen

  decimalAdded: false
  equation: 0
  matrix: 0
  cursorIndex: 0

  @construct: () ->

  @addToJax: (what, where) ->
    actualValue = $("#keyboard-#{where}-screen").val()
    newValue = @expressionMerge(actualValue, what)
    @updateInputsWith(newValue, where)
    @renderTex(newValue, where)

  @cleanScreen: (id) ->
    @updateInputsWith("", id)
    @renderTex("", id)

  @renderTex: (expression, where) ->
    MathJax.Hub.Queue(["Typeset", MathJax.Hub])
    tex = MathJax.Hub.getAllJax("MathOutput-#{where}")[0]
    MathJax.Hub.queue.Push [
      'Text'
      tex
      '\\displaystyle{' + expression + '}'
    ]

  @expressionMerge: (oldValue, newValue) ->
    if @recognizeMatrix(oldValue)
      return oldValue.split("\\end{matrix}").join("#{newValue}\\end{matrix}")
    if @recognizeBrackets(oldValue)
      return oldValue.replace "}", newValue + "}"
    oldValue + newValue

  @recognizeMatrix: (expression) ->
    findMatrix = ///\{matrix\}///
    (expression.match findMatrix)?

  @recognizeBrackets: (expression) ->
    findBrackets = ///\}$///
    (expression.match findBrackets)?

  @updateInputsWith: (newValue, where) ->
    $("#keyboard-#{where}-screen").val(newValue)
    $("#question_#{where}_response").val(newValue)
