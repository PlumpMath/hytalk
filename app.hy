; Copyright (c) Paul R. Tagliamonte <tag@pault.ag>, 2013 under the terms of
; hy.

(import [flask [ Flask render-template request]])

(import [pygments [highlight]])
(import [pygments.lexers [PythonLexer ClojureLexer]])
(import [pygments.formatters [HtmlFormatter]])

(import [hy.importer [import-buffer-to-ast]])
(import [astor.codegen])
(import [autopep8])

(def lexers {"python" (PythonLexer)
             "lisp"   (ClojureLexer)})


(def app (Flask "__main__"))  ; long story, needed hack


(with-decorator (.route app "/")
  (defn index []
    "Entry point"
    (render-template "slides.html")))


(defn colorize-python [x]
  (highlight x (get lexers "python") (HtmlFormatter)))


(defn hy-to-py [hython]
  (.to_source astor.codegen (import-buffer-to-ast hython)))


(with-decorator (kwapply (.route app "/format/<language>") {"methods" ["POST"]})
  (defn format-code [language]
    "Language HTML Formatter"
    (highlight
      (get request.form "code") (get lexers language) (HtmlFormatter))))


(with-decorator (kwapply (.route app "/hy2py") {"methods" ["POST"]})
  (defn translate-code []
    "Pythonic converter"
    (hy-to-py (get request.form "code"))))


(with-decorator (kwapply (.route app "/hy2pycol") {"methods" ["POST"]})
  (defn translate-code-with-color []
    "Pythonic converter"
    (colorize-python (hy-to-py (get request.form "code")))))
