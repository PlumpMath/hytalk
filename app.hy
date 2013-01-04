; Copyright (c) Paul R. Tagliamonte <tag@pault.ag>, 2013 under the terms of
; hy.

(import-from flask
             Flask render-template request)

(import-from pygments highlight)
(import-from pygments.lexers PythonLexer)
(import-from pygments.formatters HtmlFormatter)

(import-from hy.compiler.ast27 forge-ast)
(import-from hy.lex.tokenize tokenize)
(import codegen)


(def app (Flask "__main__"))


(decorate-with (.route app "/")
  (defn index []
    " Entry point "
    (render-template "slides.html")))


(decorate-with (kwapply (.route app "/topy") {"methods" ["POST"]})
  (defn topy []
    " Take Lisp input and output formated HTML Pythonic output. "
    (do
      (def code
         (.to-source codegen (forge-ast "stdin"
           (tokenize (index request.form "code")))))
      (+
        "Pythonic Output of Lisp code"
        "<style>"
        (.get_style_defs (HtmlFormatter) ".highlight")
        "</style>"
        (highlight code (PythonLexer) (HtmlFormatter))))))
