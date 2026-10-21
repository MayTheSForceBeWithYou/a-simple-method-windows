; 02-macro-exit.asm
; Create ExitWith macro, exit 7.
; Task: Define ExitWith MACRO status ... ENDM, invoke ExitWith 7.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define ExitWith macro

main PROC
    ; TODO: Invoke ExitWith 7

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
