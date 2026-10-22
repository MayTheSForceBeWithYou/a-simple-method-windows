; 21-atan2-stub.asm: Stub: atan2 approximation, exit angle
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_atan2_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_atan2_stub in this file.
    call    ex_21_atan2_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
