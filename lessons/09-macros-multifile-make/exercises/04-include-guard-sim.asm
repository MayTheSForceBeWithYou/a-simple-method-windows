; 04-include-guard-sim.asm
; IFDEF guard simulation, exit 42.
; Task: Use IFNDEF/ENDIF pattern, define constant, use it.

; TODO: IFNDEF MYCONST_DEFINED
; TODO: MYCONST_DEFINED = 1
; TODO: MYVAL EQU 42
; TODO: ENDIF

.CODE
EXTRN ExitProcess:PROC

main PROC
    ; TODO: mov ecx, MYVAL; mov ecx, 1
    call ExitProcess
main ENDP
END
