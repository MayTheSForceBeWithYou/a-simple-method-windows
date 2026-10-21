; 01-define-const.asm
; Define a constant, use it, exit 0.
; Task: Define STATUS_OK = 0 using EQU, move it to ECX, call ExitProcess.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define STATUS_OK EQU 0

main PROC
    ; TODO: mov ecx, STATUS_OK; call ExitProcess
    mov ecx, 1
    call ExitProcess
main ENDP
END
