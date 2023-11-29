section .rodata
planets:
        dd 0.2408467 ; MERCURY
        dd 0.61519726 ; VENUS
        dd 1.0 ; EARTH
        dd 1.8808158 ; MARS
        dd 11.862615 ; JUPITER
        dd 29.447498 ; SATURN
        dd 84.016846 ; URANUS
        dd 164.79132 ; NEPTUNE
earth_year:
        dd 31557600.0 ; seconds in a year

section .text
global age
age:
    cvtsi2ss xmm0, rsi ; convert to 1.float
    divss xmm0, dword [rel earth_year] ; divide to eath year

    lea r8, [rel planets] ; load planets list
    divss xmm0, dword [r8 + rdi * 4] ; divide by the planets, index = i * 4
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
