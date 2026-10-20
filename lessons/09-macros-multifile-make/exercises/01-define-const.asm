; 01-define-const.asm
; Define a constant, use it, exit 0.
; Task: Define STATUS_OK = 0 using EQU, move it to ECX, call ExitProcess.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define STATUS_OK EQU 0
.ERR <TODO: Define STATUS_OK using EQU>

main PROC
    ; TODO: mov ecx, STATUS_OK; call ExitProcess
    .ERR <TODO: Use STATUS_OK constant>
main ENDP
END
