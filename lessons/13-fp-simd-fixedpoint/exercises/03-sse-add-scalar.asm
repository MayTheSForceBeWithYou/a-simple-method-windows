; 03-sse-add-scalar.asm: Stub: scalar add (no SSE), exit sum
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
