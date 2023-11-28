; Remember to comment out TEST_IGNORE() in two_fer_test.c
; Then run tests with 'make'

; PLACEMENT OF VARIABLE IS IMPORTANT, especially for equ instruction
section .rodata
  noarg db "you"
  noarg_len equ $-noarg

  prefix db "One for "
  prefix_len equ $-prefix

  suffix db ", one for me.", 0x0
  suffix_len equ $-suffix

section .text
global two_fer
two_fer:
	mov r8, rdi ; name in rax
	mov rdi, rsi ; buffer to rdi

print_prefix:
	lea rsi, [rel prefix]
	mov rcx, prefix_len
	rep movsb

	cmp r8, 0; check given name
	jz .print_noarg

	.print_arg:
		mov rsi, r8
		.loop:
			cmp byte [rsi], 0
			je .print_suffix
			movsb
			jmp .loop

	.print_noarg:
		lea rsi, [rel noarg]
		mov rcx, noarg_len
		rep movsb

	.print_suffix:
		lea rsi, [rel suffix]
		mov rcx, suffix_len
		rep movsb
		ret


%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
