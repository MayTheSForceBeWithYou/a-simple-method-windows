; 06-extern-sim-onefile.asm
; Single-file simulation of external function, exit 5.
; Task: Define helper function, call it from main, exit with result.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define helper PROC that returns 5 in RAX

main PROC
    ; TODO: call helper; mov ecx, eax; mov ecx, 1
    call ExitProcess
main ENDP
END
