; 02-macro-exit.asm
; Create ExitWith macro, exit 7.
; Task: Define ExitWith MACRO status ... ENDM, invoke ExitWith 7.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define ExitWith macro
.ERR <TODO: ExitWith MACRO status; mov ecx, status; call ExitProcess; ENDM>

main PROC
    ; TODO: Invoke ExitWith 7
    .ERR <TODO: ExitWith 7>
main ENDP
END
