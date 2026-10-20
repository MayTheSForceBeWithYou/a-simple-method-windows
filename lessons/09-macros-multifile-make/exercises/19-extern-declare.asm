; 19-extern-declare.asm
; Single file, define helper returning 9, exit 9.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define helper returning 9
.ERR <TODO: helper PROC; mov rax, 9; ret; helper ENDP>

main PROC
    ; TODO: call helper; mov ecx, eax; call ExitProcess
    .ERR <TODO: Call helper, exit 9>
main ENDP
END
