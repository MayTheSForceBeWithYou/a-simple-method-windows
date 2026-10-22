; Exercise: 15-local-slot-alloc
;
; Allocate 3 locals; next_slot=3; exit 3.
;
; Contract: implement `ex_15_local_slot_alloc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_15_local_slot_alloc:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_local_slot_alloc in this file.
    call    ex_15_local_slot_alloc
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
