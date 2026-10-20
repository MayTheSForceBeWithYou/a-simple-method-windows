; 14-multifile-sim-globals.asm
; Single-file simulation of PUBLIC, return 42.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define helper that returns 42
.ERR <TODO: helper PROC; mov rax, 42; ret; helper ENDP>

main PROC
    ; TODO: call helper; mov ecx, eax; call ExitProcess
    .ERR <TODO: Call helper, exit 42>
main ENDP
END
