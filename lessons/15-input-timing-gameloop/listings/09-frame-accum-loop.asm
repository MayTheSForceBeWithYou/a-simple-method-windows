; Listing 09: Fixed-step accumulator loop (LESSON.md block 9)
; Expected exit: 2
; Expected stdout: (none)

.DATA?
accum QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     accum, 32
    xor     rcx, rcx
update_loop:
    cmp     accum, 16
    jl      render
    cmp     rcx, 3
    jge     render
    sub     accum, 16
    inc     rcx
    jmp     update_loop
render:
    mov     ecx, ecx
    call    ExitProcess
main ENDP
END
