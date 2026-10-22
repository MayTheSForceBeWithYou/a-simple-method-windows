; 03-sse-add-scalar.asm: Stub: scalar add (no SSE), exit sum
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_sse_add_scalar:PROC
main PROC
    ; TODO: write ex_03_sse_add_scalar in this file.
    call    ex_03_sse_add_scalar
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
