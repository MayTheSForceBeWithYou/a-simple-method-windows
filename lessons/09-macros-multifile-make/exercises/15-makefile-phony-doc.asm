; 15-makefile-phony-doc.asm
; Comment about .PHONY targets, exit 0.

.CODE
EXTRN ExitProcess:PROC

; .PHONY in Makefile marks non-file targets like "clean" or "all"

main PROC
    ; TODO: xor ecx, ecx; call ExitProcess
main ENDP
END
