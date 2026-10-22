; 16-clock-gettime-stub.asm
;
; Query performance counter (high-resolution timer), exit 0.
;
; Task: Call QueryPerformanceCounter with pointer to QWORD, exit 0.
;
; Hint: QueryPerformanceCounter(&counter) returns nonzero on success.

.DATA
counter QWORD ?

.CODE

EXTRN QueryPerformanceCounter:PROC
EXTRN ExitProcess:PROC
EXTRN ex_16_clock_gettime_stub:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_16_clock_gettime_stub (student routine; defined in solutions/).
    call    ex_16_clock_gettime_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
