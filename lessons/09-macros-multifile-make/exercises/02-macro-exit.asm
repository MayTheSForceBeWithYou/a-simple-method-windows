; Exercise: 02-macro-exit
;
; Exercise 02: macro exit
; MACRO exit_with code ... ENDM; exit 7.
;
; Contract: implement `ex_02_macro_exit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;

; 02-macro-exit.asm
; Create ExitWith macro, exit 7.
; Task: Define ExitWith MACRO status ... ENDM, invoke ExitWith 7.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_macro_exit:PROC

; TODO: Define ExitWith macro

main PROC
    sub     rsp, 40
    ; TODO: Invoke ExitWith 7
    ; TODO: write ex_02_macro_exit in this file.
    call    ex_02_macro_exit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
