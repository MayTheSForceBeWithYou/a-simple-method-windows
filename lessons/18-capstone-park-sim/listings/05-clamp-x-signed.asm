; Listing 05: Signed clamp x to [0, width) (LESSON.md block 5)
; Expected exit: 7
; Expected stdout: (none)

width EQU 8

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     rax, 99
    cmp     rax, 0
    jge     x_not_negative
    xor     rax, rax
x_not_negative:
    cmp     rax, width
    jl      x_ok
    mov     rax, width
    dec     rax
x_ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
