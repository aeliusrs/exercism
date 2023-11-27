default rel

; Remember to comment out TEST_IGNORE() in two_fer_test.c
; Then run tests with 'make'

section .rodata
  noarg db "One for you, one for me.", 0x0a
  prefix db "One for ", 0x0a
  suffix db ", one for me.", 0x0a

  noarg_len equ $-noarg
  prefix_len equ $-prefix
  suffix_len equ $-suffix

global two_fer
section .text
two_fer:
    ; save name in r8d register
    ; save buffer in r9d register
    mov rdi, r8
    mov rsi, r9

    ; check if name is null
    cmp r8, 0
    je print_noarg
ret


%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
