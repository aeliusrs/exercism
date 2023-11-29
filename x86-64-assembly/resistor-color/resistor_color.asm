default rel

section .data ; should not use .rodata
black: db "black", 0 ; db = define bytes, allocates a list of bytes
brown: db "brown", 0
red: db "red", 0
orange: db "orange", 0
yellow: db "yellow", 0
green: db "green", 0
blue: db "blue", 0
violet: db "violet", 0
grey: db "grey", 0
white: db "white", 0

; dq = define qword, a list of element of 64bits
arr: dq black, brown, red, orange, yellow, green, blue, violet, grey, white, 0x0

section .text
global color_code
color_code:
    lea r10, [arr] ; load array
    mov r11, rdi   ; save value for later
    mov r8, 0      ; init index
    .loop:
        cmp qword [r10 + r8 * 8], qword 0
        je .quit

        mov rdi, r11 ; reload arg
        mov rsi, [r10 + r8 * 8] ; load the string from array
        call streq
        cmp rax, 0  ; are string equal ?
        je .ok
        inc r8
        jmp .loop 
    .ok:
     mov rax, r8 ; return the index as index = value
    .quit:
     ret

streq:
    .loop:
      mov al, byte [rdi]     ; Read character from target
      cmp al, byte [rsi]     ; Compare with character from input
      jne .neq               ; Jump if not equal
      cmp byte [rdi], 0      ; Check if end of target string
      je .eq                 ; Jump if end of target string reached
      inc rdi                ; Move to next character in target string
      inc rsi                ; Move to next character in input string
      jmp .loop              ; Continue looping
    .neq:
      mov rax, 1             ; Set result to false (1)
      ret
    .eq:
      xor rax, rax           ; Set result to true (0)
      ret

global colors
colors:
    lea rax, [arr] ; load the colors in return
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
