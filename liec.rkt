#lang racket
(require "parser.rkt"
         "compilateur.rkt")

(define argv (current-command-line-arguments))
(cond
  ((>= (vector-length argv) 0)
   (define in (open-input-file "test.rkt"))
   (port-count-lines! in)
   (define parsed (liec-parser in))
   (close-input-port in)
   (define resultat (compilation parsed))
   (printf "Parsing ok.\n")
   (define out (open-output-file "reponse.s" #:exists 'truncate))
   (write-string (apply string-append
                        (append  (list "main:\n" resultat) 
                                (list "move $a0, $v0\n"
                                       "li $v0, 1\n"
                                       "syscall\n"
                                       "jr $ra\n" )))out)
                                     
   (close-output-port out)

   ))