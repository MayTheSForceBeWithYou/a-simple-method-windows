; 02-macro-exit.asm
; Create ExitWith macro, exit 7.
; Task: Define ExitWith MACRO status ... ENDM, invoke ExitWith 7.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_macro_exit:PROC

; TODO: Define ExitWith macro

main PROC
    ; TODO: Invoke ExitWith 7
    ; TODO: implement ex_02_macro_exit (student routine; defined in solutions/).
    call    ex_02_macro_exit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
