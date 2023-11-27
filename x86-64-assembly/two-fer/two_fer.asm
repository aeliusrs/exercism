default rel

; Remember to comment out TEST_IGNORE() in two_fer_test.c
; Then run tests with 'make'

section .rodata
  prefix db "One for "
  noarg db "you"
  suffix db ", one for me.", 0x0

  noarg_len equ $-noarg
  prefix_len equ $-prefix
  suffix_len equ $-suffix

global two_fer
section .text
two_fer:
    mov r8, rdi

    jmp .print_prefix

    cmp r8, 0
    jz .print_noarg
;    jmp .print_arg

    jmp .print_suffix
    ret

    .print_prefix:
    mov rdi, rsi
    lea rsi, [rel prefix]
    mov rcx, prefix_len
    repe movsb
    ret

    .print_noarg:
    mov rdi, rsi
    lea rsi, [rel noarg]
    mov rcx, noarg_len
    repe movsb
    ret

    .print_arg:
    mov rdi, rsi
    lea rsi, [rel r8]
    mov rcx, 10
    repe movsb
    ret


    .print_suffix:
    mov rdi, rsi
    lea rsi, [rel suffix]
    mov rcx, suffix_len
    repe movsb
    ret



%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
