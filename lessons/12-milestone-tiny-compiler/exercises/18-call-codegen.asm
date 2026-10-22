; Exercise: 18-call-codegen
;
; Exercise 18: call codegen
; Compile call: function returns 11; exit 11.
;
; Contract: implement `ex_18_call_codegen` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 11
;

; 18-call-codegen.asm: Generate call instruction, exit 0

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_18_call_codegen:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_call_codegen in this file.
    call    ex_18_call_codegen
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
