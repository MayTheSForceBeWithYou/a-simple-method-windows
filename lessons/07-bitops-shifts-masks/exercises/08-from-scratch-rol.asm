; 08-from-scratch-rol.asm (from scratch)
;
; Use ROL (rotate left) to move bits without losing them.
;
; Task: Load 081h (binary 10000001) into AL.
;       Rotate left by 1 bit.
;       Exit with the result (should be 003h = 3, binary 00000011).
;
; Hint: ROL shifts bits left, but the bit that exits the MSB
;       re-enters at the LSB. No bit is lost.
;       After rotating 10000001 left by 1, you get 00000011.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_rol:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_08_from_scratch_rol (student routine; defined in solutions/).
    call    ex_08_from_scratch_rol
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
