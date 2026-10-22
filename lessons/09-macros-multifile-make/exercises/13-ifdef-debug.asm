; 13-ifdef-debug.asm
; IFDEF DEBUG keeps mov ecx, 1; exit 1.

; Uncomment to enable debug:
; DEBUG = 1

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_ifdef_debug:PROC

main PROC
    ; TODO: IFDEF DEBUG; mov ecx, 1; ELSE; xor ecx, ecx; ENDIF
    ; TODO: implement ex_13_ifdef_debug (student routine; defined in solutions/).
    call    ex_13_ifdef_debug
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
