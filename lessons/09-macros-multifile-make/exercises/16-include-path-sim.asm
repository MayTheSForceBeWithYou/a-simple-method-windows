; 16-include-path-sim.asm
; Define VERSION = 3, exit 3.

; TODO: VERSION EQU 3

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_include_path_sim:PROC

main PROC
    ; TODO: mov ecx, VERSION; mov ecx, 1
    ; TODO: implement ex_16_include_path_sim (student routine; defined in solutions/).
    call    ex_16_include_path_sim
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
