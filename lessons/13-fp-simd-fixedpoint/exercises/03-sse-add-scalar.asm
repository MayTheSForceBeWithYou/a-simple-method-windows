; 03-sse-add-scalar.asm: Stub: scalar add (no SSE), exit sum
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_sse_add_scalar:PROC
main PROC
    ; TODO: implement ex_03_sse_add_scalar (student routine; defined in solutions/).
    call    ex_03_sse_add_scalar
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
