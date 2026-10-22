; Exercise: 21-formation-slot
;
; Exercise 21: formation slot
; Slot index 2 offset; exit 2.
; Expected stdout: (none)
;
; Contract: implement `ex_21_formation_slot` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; 21-formation-slot: formation slot
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_formation_slot:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_formation_slot in this file.
    call    ex_21_formation_slot
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
