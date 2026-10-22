; 20-sqrt-newton-stub.asm: Stub: Newton sqrt iteration, exit approx
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_sqrt_newton_stub:PROC
main PROC
    ; TODO: write ex_20_sqrt_newton_stub in this file.
    call    ex_20_sqrt_newton_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
