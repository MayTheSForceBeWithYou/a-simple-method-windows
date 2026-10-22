; Exercise: 16-qpc
;
; Exercise 16: clock gettime stub
; QueryPerformanceCounter into counter; exit 0 if successful.
;
; Contract: implement `ex_16_qpc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 16-qpc.asm
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
EXTRN ex_16_qpc:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_qpc in this file.
    call    ex_16_qpc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
