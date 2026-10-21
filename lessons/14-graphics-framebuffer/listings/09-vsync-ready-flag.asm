; Listing 09: Frame pacing with QueryPerformanceCounter (spin until tick delta)
; Expected exit: 3
; Expected stdout: (none)
;
; Completes three QPC wait loops; exit code equals the number of waits.

.DATA?
qpc_start QWORD ?
qpc_now QWORD ?
frame_target QWORD ?

.CODE
EXTRN QueryPerformanceCounter:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 32
    .allocstack 32
    .endprolog

    lea     rcx, qpc_start
    call    QueryPerformanceCounter
    mov     rax, QWORD PTR qpc_start
    add     rax, 1
    mov     frame_target, rax

    xor     ebx, ebx

frame_wait_loop:
    lea     rcx, qpc_now
wait_spin:
    call    QueryPerformanceCounter
    mov     rax, QWORD PTR qpc_now
    cmp     rax, QWORD PTR frame_target
    jl      wait_spin

    inc     ebx
    cmp     ebx, 3
    jge     frames_done

    mov     rax, QWORD PTR qpc_now
    add     rax, 1
    mov     frame_target, rax
    jmp     frame_wait_loop

frames_done:
    mov     ecx, ebx
    call    ExitProcess
main ENDP
END
