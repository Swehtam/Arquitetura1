			.text
N1:			addi $sp, $sp, -12
			sw $ra, 8($sp)
			sw $s0, 4($sp)
			sw $a0, 0($sp)		# estaca as variaveis na pilha
			
			addi $t0, $zero, 1
			bne $a0, $t0, N2	# checa se n = 1, se nao for vai para P2
			addi $v0, $zero, 1
			j end				# se n = 1, entao a saida eh 1
		
N2: 		addi $t0, $zero, 2
			bne $a0, $t0, PN2	# checa se n = 2, se nao for vai para PN2
			addi $v0, $zero, 1	# se n = 2, entao a saida eh 2
			j end

PN2:		addi $a0, $a0, -2
			jal N1
			move $t0, $v0
			lw $a0, 0($sp)
			sub $a0, $a0, $t0
			jal N1
			move $s0, $v0
			j PN1
			
PN1:		lw $a0, 0($sp)
			addi $a0, $a0, -1
			jal N1
			move $t0, $v0
			lw $a0, 0($sp)
			sub $a0, $a0, $t0
			jal N1
			move $a0, $v0
			jal N1
			move $a0, $v0
			jal N1
			add $v0, $s0, $v0
			j end
			
			
end:	 	lw $a0, 0($sp)
			lw $s0, 4($sp)
			lw $ra, 8($sp)
			addi $sp, $sp, 12
			jr $ra
			
			.data
valor:		.asciiz "digite um valor para colocar na funcao : "
funcao1:	.asciiz "a("
funcao2:	.asciiz ") = "
linha: 		.asciiz "\n"

			.text
			.globl main
		
main:		addi $sp, $sp, -4
			sw $ra, 0($sp)
			
			li $v0, 4
			la $a0, valor
			syscall 			# printa string  para digitar um valor
			
			li $v0, 5
			syscall				# Le o input do usuario
			move $t0, $v0
			
			li $v0, 4
			la $a0, funcao1
			syscall 			# printa comeco da string da funcao

			li $v0, 1
			addi $a0, $t0, 0
			syscall				# printa o input do usuario
			
			li $v0, 4
			la $a0, funcao2
			syscall 			# printa final da string da funcao
			
			move $a0, $t0
			jal N1				# Chama a funcao a(n)=... com o input do usuario
			
			move $a0, $v0	
			li $v0, 1
			syscall				# Printa o resultado da chamada da funcao
			
			li $v0, 4
			la $a0, linha
			syscall 			# pula linha
			
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			
			li $v0, 10
			syscall