; Listing 09: Frame pacing with Sleep (three 1ms waits)
; Expected exit: 3
; Expected stdout: (none)
;
; Completes three frame waits; exit code equals the wait count.
;
; We use Sleep(1) here instead of a QueryPerformanceCounter spin-wait: QPC can pace
; frames precisely but burns CPU. Sleep is coarse (often ~1-16 ms per call depending
; on timer resolution). Lesson 15 teaches QPC frame timing (01-qpc-timing, 02-delta-time).

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
