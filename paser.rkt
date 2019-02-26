#lang racket/base


(require parser-tools/yacc
         parser-tools/lex
         "lexer.rkt")

(provide liec-parser)

(require (for-syntax racket/base))
(define-syntax (sp stx)
  (datum->syntax
   stx
   (string->symbol (string-append "$" (number->string (cadr (syntax->datum stx)))
                                  "-start-pos"))))

(define parse
  (parser
   (src-pos)
   (tokens operators numbers)
   (start prog)
   (end Eof)

   (grammar

    (prog
     ((expr) $1))
  

     (expr
      ((expr LSoustraction term) (list '- $1 $3))
      ((expr LAddition term) (list '+ $1 $3))  
      ((term) $1))

     (term
      ((term LMultiplication fact)  (list '* $1 $3))
      ((term LDivision fact)  (list '/ $1 $3))
      ((term LModulo fact)  (list '% $1 $3))
      ((fact) $1))

     (fact
      ((Lopar expr Lcpar) $2)
      ((Int) $1)))

       
  
     

   (precs (left LModulo)
          (left LAddition)
          (left LSoustraction)
          (left LMultiplication)
          (left LDivision))

   (error
    (lambda (ok? name value s-pos e-pos)
      (eprintf "Parser: ~a: ~a~a on line ~a col ~a.\n"
               (substring (symbol->string name) 1)
               (if ok? "syntax error" "unexpected token")
               (if value (format " near '~a'" value) "")
               (position-line s-pos)
               (position-col s-pos))
      (exit 1)))
   ))


(define (liec-parser in)
    (parse
     (lambda ()
       (get-token in))))



