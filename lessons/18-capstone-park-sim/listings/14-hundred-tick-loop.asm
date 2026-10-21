; Listing 14: Fixed 100-tick simulation loop with per-tick work
; Expected exit: 100
; Expected stdout: (none)

.DATA?
tick QWORD ?
accum QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     tick, 0
    mov     accum, 0

tick_loop:
    cmp     tick, 100
    jge     tick_done
    add     accum, 1
    inc     tick
    jmp     tick_loop

tick_done:
    mov     ecx, DWORD PTR accum
    call    ExitProcess
main ENDP
END
