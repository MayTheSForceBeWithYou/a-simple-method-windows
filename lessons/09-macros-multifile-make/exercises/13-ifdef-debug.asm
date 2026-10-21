; 13-ifdef-debug.asm
; IFDEF DEBUG keeps mov ecx, 1; exit 1.

; Uncomment to enable debug:
; DEBUG = 1

.CODE
EXTRN ExitProcess:PROC

main PROC
    ; TODO: IFDEF DEBUG; mov ecx, 1; ELSE; xor ecx, ecx; ENDIF
    call ExitProcess
main ENDP
END
