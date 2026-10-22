; 04-include-guard-sim.asm
; IFDEF guard simulation, exit 42.
; Task: Use IFNDEF/ENDIF pattern, define constant, use it.

; TODO: IFNDEF MYCONST_DEFINED
; TODO: MYCONST_DEFINED = 1
; TODO: MYVAL EQU 42
; TODO: ENDIF

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_include_guard_sim:PROC

main PROC
    sub     rsp, 40
    ; TODO: IFNDEF guard + MYVAL EQU 42 inside ex_04_include_guard_sim (see solutions/).
    call    ex_04_include_guard_sim
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
