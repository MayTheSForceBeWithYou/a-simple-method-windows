; Exercise: 20-alpha-stub
;
; Exercise 20: alpha stub
; Alpha blend stub: out=src if a=255; exit 7.
; Expected stdout: (none)
;
; Contract: implement `ex_20_alpha_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;

; 20-alpha-stub: alpha stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_alpha_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_alpha_stub in this file.
    call    ex_20_alpha_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
