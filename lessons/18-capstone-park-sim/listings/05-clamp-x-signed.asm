; Listing 05: Signed clamp x to [0, width) (LESSON.md block 5)
; Expected exit: 7
; Expected stdout: (none)

grid_w EQU 8

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 99
    cmp     rax, 0
    jge     x_not_negative
    xor     rax, rax
x_not_negative:
    cmp     rax, grid_w
    jl      x_ok
    mov     rax, grid_w
    dec     rax
x_ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
