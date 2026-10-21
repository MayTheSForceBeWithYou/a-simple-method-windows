; Listing 13: Sleep frame-budget padding after measured work
; Expected exit: 1
; Expected stdout: (none)
;
; Budget 10 ms; busy-wait until elapsed >= 12 ms; remaining clamps to 0; exit 1.

FRAME_BUDGET_MS EQU 10
WORK_TARGET_MS EQU 12

.DATA?
t0 QWORD ?
t1 QWORD ?

.CODE
EXTRN GetTickCount64:PROC
EXTRN Sleep:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    call    GetTickCount64
    mov     t0, rax

work_wait:
    call    GetTickCount64
    mov     t1, rax
    sub     rax, QWORD PTR t0
    cmp     rax, WORK_TARGET_MS
    jl      work_wait

    mov     rbx, rax
    mov     rax, FRAME_BUDGET_MS
    sub     rax, rbx
    jns     sleep_positive
    xor     rax, rax
    mov     ecx, 1
    jmp     do_sleep

sleep_positive:
    mov     ecx, eax
    xor     edx, edx
    jmp     do_sleep

do_sleep:
    mov     r8d, edx
    call    Sleep
    mov     ecx, r8d
    call    ExitProcess
main ENDP
END
