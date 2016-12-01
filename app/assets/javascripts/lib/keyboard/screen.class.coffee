class window.FARMA.Screen

  decimalAdded: false
  equation: 0
  matrix: 0
  cursorIndex: 0

  construct: () ->

  addToJax: (key, what, where) ->
    newTex = @expressionMerge(@getScreenTex(where), what)
    newValue = @getResponseValue(where) + key
    console.log newTex
    if window.FARMA.Validator.isNumeric(newTex)
      @switchClass(where, true)
    else
      @switchClass(where, false)
    @updateInputsWith(newValue, newTex, where)
    @renderTex(newTex, where)

  getScreenTex: (where) ->
    $("#keyboard-#{where}-screen").val()

  getResponseValue: (where) ->
    $("#question_#{where}_response").attr("data-storage")

  cleanScreen: (id) ->
    @updateInputsWith("", "", id)
    @renderTex("", id)
    $("#keyboard-#{id} .jax").removeClass('valid-expression')
    $("#keyboard-#{id} .jax").removeClass('invalid-expression')
    $("#keyboard-#{id}-screen").removeClass('invalid-expression')
    $("#keyboard-#{id}-screen").removeClass('valid-expression')

  renderTex: (expression, where) ->
    MathJax.Hub.Queue(["Typeset", MathJax.Hub])
    tex = MathJax.Hub.getAllJax("MathOutput-#{where}")[0]
    MathJax.Hub.queue.Push [
      'Text'
      tex
      '\\displaystyle{' + expression + '}'
    ]

  expressionMerge: (oldValue, newValue) ->
    if @recognizeMatrix(oldValue)
      return oldValue.split("\\end{matrix}").join("#{newValue}\\end{matrix}")
    if @recognizeBrackets(oldValue)
      return oldValue.replace "}", newValue + "}"
    oldValue + newValue

  recognizeMatrix: (expression) ->
    findMatrix = ///\{matrix\}///
    (expression.match findMatrix)?

  recognizeBrackets: (expression) ->
    findBrackets = ///\}$///
    (expression.match findBrackets)?

  updateInputsWith: (newValue, newTex, where) ->
    $("#keyboard-#{where}-screen").val(newTex)
    $("#question_#{where}_response").attr("data-storage", newValue)
    console.log(newValue)
    if window.FARMA.Validator.isNumeric(newValue)
      $("#response-#{where}").val(newValue)

  switchClass: (where, state) ->
    if (state)
      $("#keyboard-#{where}-screen").addClass('valid-expression')
      $("#keyboard-#{where}-screen").removeClass('invalid-expression')
    else
      $("#keyboard-#{where}-screen").addClass('invalid-expression')
      $("#keyboard-#{where}-screen").removeClass('valid-expression')
