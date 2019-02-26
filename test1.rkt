#lang racket

(require "parser.rkt"
         "lexer.rkt")

(provide compilation)


(define (compilation prog)  
 (match prog
  ((list '+ a b )
   (string-append
    "addi $sp,$sp,-4 \n sw $a0, 0($sp) \n"
    "addi $sp,$sp,-4 \n sw $a1, 0($sp) \n"
    (compilation a)
    "move $a0, $v0 \n"
    (compilation b)
    "move $a1,$v0\n"
    "add $v0, $a0, $a1\n"
    "lw $a1,0($sp)\n"
    "addi $sp,$sp,4 \n"
    "lw $a0,0($sp)\n"
    "addi $sp,$sp,4 \n"    
    ))
   ((list '- a b)
    (string-append
     "addi $sp,$sp,-4 \n sw $a0, 0($sp) \n"
     "addi $sp,$sp,-4 \n sw $a1, 0($sp) \n"
     (compilation a)
     "move $a0, $v0 \n"
     (compilation b)
     "move $a1,$v0\n"
     "sub $v0, $a0, $a1\n"
     "lw $a1,0($sp)\n"
     "addi $sp,$sp,4 \n"
     "lw $a0,0($sp)\n"
     "addi $sp,$sp,4 \n"    
    ))
   ((list '* a b)
     (string-append
     "addi $sp,$sp,-4 \n sw $a0, 0($sp) \n"
     "addi $sp,$sp,-4 \n sw $a1, 0($sp) \n"
     (compilation a)
     "move $a0, $v0 \n"
     (compilation b)
     "move $a1,$v0\n"
     "mul $v0, $a0, $a1\n"
     "lw $a1,0($sp)\n"
     "addi $sp,$sp,4 \n"
     "lw $a0,0($sp)\n"
     "addi $sp,$sp,4 \n"
     ))
   ((list '/ a b)
    (string-append
     "addi $sp,$sp,-4 \n sw $a0, 0($sp) \n"
     "addi $sp,$sp,-4 \n sw $a1, 0($sp) \n"
     (compilation a)
     "move $a0, $v0 \n"
     (compilation b)
      "move $a1,$v0\n"
      "div $a0, $a1\n"
      "mflo $v0 \n"
       "lw $a1,0($sp)\n"
     "addi $sp,$sp,4 \n"
     "lw $a0,0($sp)\n"
     "addi $sp,$sp,4 \n"
     ))

   ((list '% a b)
    (string-append
     "addi $sp,$sp,-4 \n sw $a0, 0($sp) \n"
     "addi $sp,$sp,-4 \n sw $a1, 0($sp) \n"
     (compilation a)
     "move $a0, $v0 \n"
     (compilation b)
      "move $a1,$v0\n"
      "div $a0, $a1\n"
      "mfhi $v0 \n"
     "lw $a1,0($sp)\n"
     "addi $sp,$sp,4 \n"
     "lw $a0,0($sp)\n"
     "addi $sp,$sp,4 \n"
     ))
    
   
  (m 
    (format "li $v0, ~a\n" m))))




