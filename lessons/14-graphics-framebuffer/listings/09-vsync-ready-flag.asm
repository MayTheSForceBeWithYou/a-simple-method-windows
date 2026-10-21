; Listing 09: Frame pacing with Sleep (three 1ms waits)
; Expected exit: 3
; Expected stdout: (none)
;
; Completes three frame waits; exit code equals the wait count.

.CODE
EXTRN Sleep:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog

    xor     ebx, ebx

frame_wait_loop:
    mov     ecx, 1
    call    Sleep
    inc     ebx
    cmp     ebx, 3
    jl      frame_wait_loop

    mov     ecx, ebx
    call    ExitProcess
main ENDP
END
