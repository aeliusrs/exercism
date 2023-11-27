section .text
global leap_year
modulo:
    mov rdx, 0
    mov rax, rdi
    mov rcx, r8
    div rcx
    cmp rdx, 0
    ret

leap_year:
    mov r8, 4
    call modulo
    jnz is_not_leap

    mov r8, 100
    call modulo
    jnz is_leap

    mov r8, 400
    call modulo
    jz is_leap

is_not_leap:
    xor rax, rax
    ret

is_leap:
    mov rax, 1
    ret


%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
