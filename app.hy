; Copyright (c) Paul R. Tagliamonte <tag@pault.ag>, 2013 under the terms of
; hy.

(import-from flask
             Flask render-template request)

(import-from pygments highlight)
(import-from pygments.lexers PythonLexer ClojureLexer)
(import-from pygments.formatters HtmlFormatter)

;(import-from hy.compiler.ast27 forge-ast)
;(import-from hy.lex.tokenize tokenize)
;(import codegen)

(def lexers {"python" (PythonLexer)
             "lisp"   (ClojureLexer)})


(def app (Flask "__main__"))  ; long story, needed hack


(decorate-with (.route app "/")
  (defn index []
    " Entry point "
    (render-template "slides.html")))


(decorate-with (kwapply (.route app "/format/<language>") {"methods" ["POST"]})
  (defn format-code [language]
    " Language HTML Formatter "
    (highlight (index request.form "code") (index lexers language) (HtmlFormatter))))
