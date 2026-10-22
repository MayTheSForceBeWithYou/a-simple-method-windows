; 21-atan2-stub.asm: Stub: atan2 approximation, exit angle
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_atan2_stub:PROC
main PROC
    ; TODO: implement ex_21_atan2_stub (student routine; defined in solutions/).
    call    ex_21_atan2_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
