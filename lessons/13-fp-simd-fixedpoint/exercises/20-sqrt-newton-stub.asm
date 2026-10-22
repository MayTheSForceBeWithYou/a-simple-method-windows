; 20-sqrt-newton-stub.asm: Stub: Newton sqrt iteration, exit approx
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_sqrt_newton_stub:PROC
main PROC
    ; TODO: implement ex_20_sqrt_newton_stub (student routine; defined in solutions/).
    call    ex_20_sqrt_newton_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
