; 06-extern-sim-onefile.asm
; Single-file simulation of external function, exit 5.
; Task: Define helper function, call it from main, exit with result.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define helper PROC that returns 5 in RAX
.ERR <TODO: helper PROC; mov rax, 5; ret; helper ENDP>

main PROC
    ; TODO: call helper; mov ecx, eax; call ExitProcess
    .ERR <TODO: Call helper, exit with result>
main ENDP
END
