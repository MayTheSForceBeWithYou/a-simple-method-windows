; Exercise: 08-from-scratch-guest-target
;
; Exercise 08: from scratch guest target
; FROM SCRATCH: guest target id 7; exit 7.
; Expected stdout: (none)
;
; Contract: implement `ex_08_from_scratch_guest_target` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;

; 08-from-scratch-guest-target: from scratch guest target
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_guest_target:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_guest_target in this file.
    call    ex_08_from_scratch_guest_target
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
