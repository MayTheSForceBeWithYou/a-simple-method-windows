; 04-include-guard-sim.asm
; IFDEF guard simulation, exit 42.
; Task: Use IFNDEF/ENDIF pattern, define constant, use it.

; TODO: IFNDEF MYCONST_DEFINED
.ERR <TODO: IFNDEF guard>
; TODO: MYCONST_DEFINED = 1
; TODO: MYVAL EQU 42
; TODO: ENDIF

.CODE
EXTRN ExitProcess:PROC

main PROC
    ; TODO: mov ecx, MYVAL; call ExitProcess
    .ERR <TODO: Use guarded constant>
main ENDP
END
