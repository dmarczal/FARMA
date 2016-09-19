class window.FARMA.Validator


  @isAlgebraic: (expression) ->

  @isNumeric: (expression) ->
    # regex = ///(\s*\d+\s*(\*|\/|\-|\+|\^|)\s*\d+\s*(\*|\/|\-|\+|\^|))+\s*///
    regex = /(^[-]?)(\b(([\(]?(?:(?:(?:\d+\.)?\d+)[\)]?(?:\^|over|sqrt|\*|\/|\+|\-)?[\(]?)+\d)|\d{1})\b)$/gm
    (expression.match regex)?

  @isMatrix: (expression) ->
    regex = ///\{matrix\}///
    (expression.match regex)?

  @isFunction: (expression) ->
    regex = //////
    (expression.match regex)?

  @isFormula: (expression) ->
    regex = //////
    (expression.match regex)?
