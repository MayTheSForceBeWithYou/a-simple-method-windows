; 07-simd-lane-sum-stub.asm: Stub: lane sum (no SIMD), exit sum
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
