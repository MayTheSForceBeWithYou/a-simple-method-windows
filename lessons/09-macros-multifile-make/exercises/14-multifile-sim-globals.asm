; 14-multifile-sim-globals.asm
; Single-file simulation of PUBLIC, return 42.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define helper that returns 42

main PROC
    ; TODO: call helper; mov ecx, eax; mov ecx, 1
    call ExitProcess
main ENDP
END
