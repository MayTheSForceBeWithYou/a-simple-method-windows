; 12-sse-movss-stub.asm: Stub: scalar move (no SSE), exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_sse_movss_stub:PROC
main PROC
    ; TODO: write ex_12_sse_movss_stub in this file.
    call    ex_12_sse_movss_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
