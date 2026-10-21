; Listing 09: Frame pacing with QueryPerformanceCounter (spin until tick delta)
; Expected exit: 3
; Expected stdout: (none)
;
; Runs three frames; each frame spins until QPC advances by at least 1 tick.

.DATA?
qpc_start QWORD ?
qpc_now QWORD ?
frame_target QWORD ?

.CODE
EXTRN QueryPerformanceCounter:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    lea     rcx, qpc_start
    call    QueryPerformanceCounter
    mov     rax, QWORD PTR qpc_start
    add     rax, 1
    mov     frame_target, rax

    xor     ebx, ebx

frame_loop:
    inc     ebx
    cmp     ebx, 3
    jge     frames_done

wait_tick:
    lea     rcx, qpc_now
    call    QueryPerformanceCounter
    mov     rax, QWORD PTR qpc_now
    cmp     rax, QWORD PTR frame_target
    jl      wait_tick

    mov     rax, QWORD PTR qpc_now
    add     rax, 1
    mov     frame_target, rax
    jmp     frame_loop

frames_done:
    mov     ecx, ebx
    call    ExitProcess
main ENDP
END
