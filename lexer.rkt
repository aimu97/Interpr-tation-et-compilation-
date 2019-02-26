#lang racket/base

(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))

(provide get-token
         operators  numbers)

(define-empty-tokens operators
  (Eof
   LAddition LSoustraction LMultiplication LDivision LModulo Lopar Lcpar))

(define-tokens identifiers
  (Var))

(define-tokens numbers
  (Int))


(define get-token
  (lexer-src-pos
   ((eof)           (token-Eof))
   (whitespace      (return-without-pos (get-token input-port)))
   ("+"             (token-LAddition))
   ("-"             (token-LSoustraction))
   ("*"             (token-LMultiplication))
   ("/"             (token-LDivision))
   ("%"             (token-LModulo))
   ("("             (token-Lopar))
   (")"             (token-Lcpar))
   ((:+ numeric)    (token-Int (string->number lexeme)))
   (any-char        (error (format "Unrecognized char '~a' at offset ~a."
                                   lexeme (position-offset start-pos))))))

