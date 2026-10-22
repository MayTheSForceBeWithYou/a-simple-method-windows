; Exercise: 13-ifdef-debug
;
; Define DEBUG; IFDEF DEBUG mov rcx,1 ELSE 0; exit 1.
;
; Contract: implement `ex_13_ifdef_debug` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_13_ifdef_debug:PROC

main PROC
    sub     rsp, 40
    ; TODO: IFDEF DEBUG / ELSE in ex_13_ifdef_debug; return exit code in eax.
    call    ex_13_ifdef_debug
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
