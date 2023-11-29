section .text
global square_root
square_root:
    ; root number is in rdi, output will be in rax
    mov r8, 1 ;this is my radicand
    .loop:
        mov rax, r8
        mul rax ; multiply by himself
        cmp rax, rdi
        jge .return
        inc r8
        jmp .loop
    .return:
        mov rax, r8
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
