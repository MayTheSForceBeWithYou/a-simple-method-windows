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
    push    rbx
    .pushreg rbx
    sub     rsp, 32
    .allocstack 32
    .endprolog

    call    GetTickCount64
    mov     t0, rax

work_wait:
    call    GetTickCount64
    mov     t1, rax
    sub     rax, QWORD PTR t0
    cmp     rax, WORK_TARGET_MS
    jl      work_wait

    mov     r8, rax
    mov     rax, FRAME_BUDGET_MS
    sub     rax, r8
    jns     sleep_has_budget

    xor     ecx, ecx
    mov     ebx, 1
    call    Sleep
    mov     ecx, ebx
    call    ExitProcess

sleep_has_budget:
    mov     ebx, 0
    mov     rcx, rax
    call    Sleep
    mov     ecx, ebx
    call    ExitProcess
main ENDP
END
