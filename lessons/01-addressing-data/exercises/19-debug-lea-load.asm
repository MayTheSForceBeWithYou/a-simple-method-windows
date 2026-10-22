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
EXTRN ex_19_debug_lea_load:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    lea rcx, x    ; BUG: fix in ex_19_debug_lea_load (should load value, not address)

__ex_call:
    ; TODO: write ex_19_debug_lea_load in this file.
    call    ex_19_debug_lea_load
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
