class window.FARMA.Keys

  @operators: ->
    [
      { key: "÷", value: "\\over", type: "operator" },
      { key: "x", value: "*", type: "operator" },
      { key: "-", value: "-", type: "operator" },
      { key: "+", value: "+", type: "operator" }
    ]

  @keys: ->
    [
      { key: 1, value: 1, type: "key" },
      { key: 2, value: 2, type: "key" },
      { key: 3, value: 3, type: "key" },

      # { key: "", value: "", type: "special mdi mdi-sigma" },
      { key: 4, value: 4, type: "key" },
      { key: 5, value: 5, type: "key" },
      { key: 6, value: 6, type: "key" },

      # { key: "", value: "", type: "special mdi mdi-function" },
      { key: 7, value: 7, type: "key" },
      { key: 8, value: 8, type: "key" },
      { key: 9, value: 9, type: "key" },

      # { key: "", value: "", type: "special mdi mdi-flask-outline" },
      { key: ".", value: ".", type: "key" },
      { key: 0, value: 0, type: "key" },
      { key: "=", value: "=", type: "key" }
      # { key: "", value: "\\left[\\begin{matrix}\\end{matrix}\\right]", type: "special mdi mdi-matrix" },
    ]

  @specialKeys: ->
    [
      { key: "√", value: "\\sqrt{}", type: "key" },
      { key: "(", value: "{", type: "key" },
      { key: ")", value: "}", type: "key" },
      { key: "", value: "", type: "eval mdi mdi-desktop-mac tooltipped", options: "data-tooltip=Renderizar TeX data-delay=50 data-position=bottom" },
      # { key: "", value: "check", type: "eval mdi mdi-account-check" }
      # { key: "", value: "\\left[\\begin{matrix}\\end{matrix}\\right]", type: "operator mdi mdi-matrix" },
      # { key: "&", value: "&", type: "key" },
      # { key: "𝑥²", value: "^2", type: "key" },
      # { key: "%", value: "*100", type: "key" },
      # { key: "", value: "\\\\", type: "operator mdi mdi-keyboard-return" }
    ]

  @functions: ->
    [
      { key: "√", value: "\\sqrt{}", type: "key" },
      { key: "ϰ^y^", value: "{", type: "key" },
      { key: "1/ϰ", value: "{", type: "key" },
      { key: "y√ϰ", value: "{", type: "key" },
      { key: "x/y", value: "{", type: "key" },
      { key: "ln(ϰ)", value: "{", type: "key" },
      { key: "e^ϰ^", value: "{", type: "key" },
      { key: "log(ϰ)", value: "{", type: "key" },
      { key: "n!", value: "{", type: "key" },
      { key: "|ϰ|", value: "}", type: "key" }
    ]

  @matrix: ->
    [
      { key: "", value: "\\left[\\begin{matrix}\n\t\n\\end{matrix}\\right]", type: "operator mdi mdi-matrix" },
      { key: "&", value: "&", type: "key" },
      { key: "", value: "\\\\\n\t", type: "operator mdi mdi-keyboard-return" }
    ]

  @trig: ->
    [
      { key: "sin(ϰ)", value: "\\sin", type: "key" },
      { key: "sin-¹(ϰ)", value: "\\arcsin", type: "key" },
      { key: "π", value: "π", type: "key" },
      { key: "cos(ϰ)", value: "\\cos", type: "key" },
      { key: "cos-¹(ϰ)", value: "\\arccos", type: "key" },
      { key: "θ", value: "θ", type: "key" },
      { key: "tan(ϰ)", value: "\\tan", type: "key" },
      { key: "tan-¹(ϰ)", value: "\\arctan", type: "key" },
      { key: "α", value: "α", type: "key" }
    ]
