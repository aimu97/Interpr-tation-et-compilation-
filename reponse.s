main:
addi $sp,$sp,-4 
 sw $a0, 0($sp) 
addi $sp,$sp,-4 
 sw $a1, 0($sp) 
addi $sp,$sp,-4 
 sw $a0, 0($sp) 
addi $sp,$sp,-4 
 sw $a1, 0($sp) 
addi $sp,$sp,-4 
 sw $a0, 0($sp) 
addi $sp,$sp,-4 
 sw $a1, 0($sp) 
li $v0, 21
move $a0, $v0 
li $v0, 23
move $a1,$v0
div $a0, $a1
mfhi $v0 
lw $a1,0($sp)
addi $sp,$sp,4 
lw $a0,0($sp)
addi $sp,$sp,4 
move $a0, $v0 
li $v0, 22
move $a1,$v0
add $v0, $a0, $a1
lw $a1,0($sp)
addi $sp,$sp,4 
lw $a0,0($sp)
addi $sp,$sp,4 
move $a0, $v0 
addi $sp,$sp,-4 
 sw $a0, 0($sp) 
addi $sp,$sp,-4 
 sw $a1, 0($sp) 
li $v0, 345
move $a0, $v0 
li $v0, 67
move $a1,$v0
mul $v0, $a0, $a1
lw $a1,0($sp)
addi $sp,$sp,4 
lw $a0,0($sp)
addi $sp,$sp,4 
move $a1,$v0
sub $v0, $a0, $a1
lw $a1,0($sp)
addi $sp,$sp,4 
lw $a0,0($sp)
addi $sp,$sp,4 
move $a0, $v0
li $v0, 1
syscall
jr $ra
