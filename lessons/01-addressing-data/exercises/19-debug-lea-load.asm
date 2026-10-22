; Exercise: 19-debug-lea-load
;
; BUG: used lea to 'load' value. Fix to mov from memory; x QWORD 55; exit 55.
;
; Contract: implement `ex_19_debug_lea_load` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 55
;
.DATA
x QWORD 55

.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_19_debug_lea_load:PROC

main PROC
    sub     rsp, 40
    ; BUG: see exercise description; implement fix in student routine.
    ; TODO: write ex_19_debug_lea_load in this file.
    call    ex_19_debug_lea_load
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
