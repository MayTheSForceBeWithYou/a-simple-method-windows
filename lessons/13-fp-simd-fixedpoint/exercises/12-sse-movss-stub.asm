; 12-sse-movss-stub.asm: Stub: scalar move (no SSE), exit 0
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
