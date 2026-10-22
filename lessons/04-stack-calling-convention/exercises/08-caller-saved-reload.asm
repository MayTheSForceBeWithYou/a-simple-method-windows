; Exercise: 08-caller-saved-reload
;
; Put 5 in r10; call function that returns 1; add r10 — must save r10 (volatile). Exit 6.
;
; Contract: implement `ex_08_caller_saved_reload` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_08_caller_saved_reload:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_caller_saved_reload in this file.
    call    ex_08_caller_saved_reload
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
